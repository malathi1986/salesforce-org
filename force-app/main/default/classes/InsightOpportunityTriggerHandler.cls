public with sharing class InsightOpportunityTriggerHandler {
    public static void getBusinessValueShare(List<InsightOpportunity__c> insightOpps) {
        
        Set<Id> insightIds = new Set<Id>();
        for(InsightOpportunity__c insightOpp:insightOpps){
            insightIds.add(insightOpp.Insight__c);
        }
       
       // We have to identify the other insight opportunities linked to the insight records
       Map<Id, Insight__c> insightMap = new Map<Id, Insight__c>([SELECT Id, (SELECT Id, BusinessValueShare__c FROM InsightOpportunities__r) FROM Insight__c WHERE Id IN : insightIds]);

       for(InsightOpportunity__c insightOpp : insightOpps){
         //Current percentage
         Decimal currentPercentage = insightOpp.BusinessValueShare__c;
         // Existing insight opportunities percentage
         Insight__c insight = insightMap.get(insightOpp.Insight__c);
         List<InsightOpportunity__c> existingInsightOpportunities = insight.InsightOpportunities__r;
         for (InsightOpportunity__c existingInsightOpp : existingInsightOpportunities) {
            currentPercentage = currentPercentage + existingInsightOpp.BusinessValueShare__c;
            //ystem.debug(LoggingLevel.INFO, 'currentPercentage===> '+currentPercentage);
         }
         if(currentPercentage > 100){
            //System.debug(LoggingLevel.INFO, 'currentPercentage===> '+currentPercentage);
            insightOpp.addError('You cannot add insight junction records with combined percentage more than 100');
         }

        }
       }
    public static void getBusinessValuePercentage(List<InsightOpportunity__c> insightOpps) {
        //Percentage - Insight Opporunity
        //Business Value Amount - Insight 
        //Opportunity Id - Insight Opportunity
        //Insight Id - Insight Opportunity
      List<InsightOpportunity__c> businessValueRecords=[SELECT Id,BusinessValueShare__c,
                                                        Opportunity__c,Insight__r.BusinessValue__c,
                                                        Active__c  
                                                        FROM InsightOpportunity__c WHERE Id IN:insightOpps];
      List<Opportunity> oppAmountList=new List<Opportunity>();
      for(InsightOpportunity__c busineesValueRecord:businessValueRecords){
        Opportunity opp = null;
        if(busineesValueRecord.Active__c==false){
            opp=new Opportunity(Id=busineesValueRecord.Opportunity__c,Amount=0);
            //oppAmountList.add(opp);
        }else{
            Decimal percentageOfInsightOpp=busineesValueRecord.BusinessValueShare__c;
            Decimal businessValueAmount=busineesValueRecord.Insight__r.BusinessValue__c;
            Decimal oppAmount=(percentageOfInsightOpp*businessValueAmount)/100;
            opp=new Opportunity(Id=busineesValueRecord.Opportunity__c,Amount=oppAmount);
       }
        oppAmountList.add(opp);
      }
      update oppAmountList;
    }
    public static void splitBusinessValueShare(Map<Id, InsightOpportunity__c> newMap, Map<Id, InsightOpportunity__c> oldMap){
        //check the check box status for inactive(false)
        //get the business value share value and its corresponding Insight
        System.debug(LoggingLevel.INFO, 'isPercentageChanged 0 --->');
        Set<Id> insightIds = new Set<Id>();
        Boolean isPercentageChanged = false;
        for(InsightOpportunity__c insightOpp:newMap.values()){
            insightIds.add(insightOpp.Insight__c);
            if(insightOpp.Active__c !=oldMap.get(insightOpp.Id).Active__c
              && (insightOpp.Active__c == false && oldMap.get(insightOpp.Id).Active__c == true)){
                isPercentageChanged = true;
            }      
        }
        
        System.debug(LoggingLevel.INFO, 'isPercentageChanged 1 --->'+isPercentageChanged);

        if(isPercentageChanged){
            Map<Id, Insight__c> insightMap = new Map<Id, Insight__c>([SELECT Id,
                                                                        (SELECT Id,
                                                                                Active__c, 
                                                                                BusinessValueShare__c 
                                                                        FROM InsightOpportunities__r
                                                                        WHERE Active__c = true) 
                                                                    FROM Insight__c 
                                                                    WHERE Id IN : insightIds]);
            
            Map<Id,InsightOpportunity__c> updatePercentageRecords=new Map<Id,InsightOpportunity__c>();                                                
            for(InsightOpportunity__c insightOpp:newMap.values()){
                System.debug(LoggingLevel.INFO, 'insightOpp '+insightOpp);
                if(insightOpp.Active__c==false){
                    Decimal percentage= insightOpp.BusinessValueShare__c;
                    Insight__c insight = insightMap.get(insightOpp.Insight__c);
                    List<InsightOpportunity__c> existingInOps = insight.InsightOpportunities__r;
                    Decimal dividePercentage= percentage/existingInOps.size();
                    System.debug(LoggingLevel.INFO, 'existingInOps '+existingInOps);
                    System.debug(LoggingLevel.INFO, 'dividePercentage '+dividePercentage);
                    for(InsightOpportunity__c existingInsightOpp:existingInOps){
                        if(insightOpp.Id!=existingInsightOpp.Id){
                            Decimal updatedPercentage=existingInsightOpp.BusinessValueShare__c+dividePercentage;
                            InsightOpportunity__c updateRecord=new InsightOpportunity__c();
                            updateRecord.Id=existingInsightOpp.Id;
                            updateRecord.BusinessValueShare__c=updatedPercentage;
                            updatePercentageRecords.put(updateRecord.Id, updateRecord);
                        }
                    }
                }
            }
            Database.update(updatePercentageRecords.values(),false);
        }
    }
    public static void updateOpportunityBasedonInsight(List<Insight__c> insightRecords){
        //Insight Id- Insight Record
        //Business Value- Insight Record
        //Will get the Insight Id and Business value from Trigger.New(Insight Records)
        //With the help of Parent Insight Id find out the related child records(InsightOpportunities) for the corresponding Insight
        Map<Id, Insight__c> insightMap = new Map<Id, Insight__c>
                                                   ([SELECT Id, 
                                                    (SELECT Id, BusinessValueShare__c ,Opportunity__c
                                                    FROM InsightOpportunities__r) 
                                                    FROM Insight__c WHERE Id IN : insightRecords]);
        
        List<Opportunity> oppAmountList=new List<Opportunity>();     
        Map<Id,Opportunity> oppUpdateMap=new Map<Id,Opportunity>();                                                


        /*Iterate the insightRecords(From Trigger.New )and get all the Insight Records to get the 
        InsightAmount */
        for(Insight__c insightRecord:insightRecords){
            Decimal insightAmount=insightRecord.BusinessValue__c;
            /*pass The insightRecord Id to the Map Collection and to get the Realted Child records for the 
            corresponding Insight*/
           Insight__c insightChildRecords = insightMap.get(insightRecord.Id);
           System.debug(LoggingLevel.INFO, 'ChildRecords===> '+JSON.serializePretty(insightChildRecords));

            List<InsightOpportunity__c> insightOppRecords = insightChildRecords.InsightOpportunities__r;
            System.debug(LoggingLevel.INFO, 'insightOppRecords===> '+insightOppRecords);
       //Iterate the insightOppRecords(child Records of each Insight to get the value of the percentage)
            for (InsightOpportunity__c insightOppRecord : insightOppRecords) {
                Decimal percentageOfInsightOpp = insightOppRecord.BusinessValueShare__c;
                Decimal oppAmount=(percentageOfInsightOpp*insightAmount)/100;
                Opportunity opp=new Opportunity(Id=insightOppRecord.Opportunity__c,Amount=oppAmount);
                oppUpdateMap.put(opp.Id, opp);
            }  
         }
         update oppUpdateMap.values();
    }
}