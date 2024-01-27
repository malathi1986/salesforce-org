/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
public class InsightOpportunityTriggerHandlerTest {
    @testsetup
    public static void createTestData(){
        Insight__c insightRec=new Insight__c(Name='Test-BusinessValuePercentage',BusinessValue__c=1000);
        insert insightRec; 

        List<Opportunity> oppRecords = new List<Opportunity>();
        Opportunity oppRec=new Opportunity(Name ='Test-BusinessValuePercentage',closedate=System.today(), 
        StageName='Prospecting',amount=10000);
        oppRecords.add(oppRec);
        Opportunity oppRec1=new Opportunity(Name ='Test-BusinessValuePercentage1',closedate=System.today(), 
        StageName='Prospecting',amount=10000);
        oppRecords.add(oppRec1);
        Opportunity oppRec2=new Opportunity(Name ='Test-BusinessValuePercentage2',closedate=System.today(), 
        StageName='Prospecting',amount=10000);
        oppRecords.add(oppRec2);
        insert oppRecords;

        List<InsightOpportunity__c> insightOppList=new List<InsightOpportunity__c>();
        InsightOpportunity__c insightOpp=new InsightOpportunity__c(Insight__c=insightRec.id,BusinessValueShare__c=10,Opportunity__c=oppRecords[0].id,Active__c=true);
        InsightOpportunity__c insightOpp1=new InsightOpportunity__c(Insight__c=insightRec.id,BusinessValueShare__c=10,Opportunity__c=oppRecords[1].id,Active__c=true);
        InsightOpportunity__c insightOpp2=new InsightOpportunity__c(Insight__c=insightRec.id,BusinessValueShare__c=10,Opportunity__c=oppRecords[2].id,Active__c=false);
        insightOppList.add(insightOpp);
        insightOppList.add(insightOpp1);
        insightOppList.add(insightOpp2);
        insert insightOppList;
    }

   @isTest
    public static void validate_SumOfgetBusinessValueShare_notExceed100Percentage(){
        Test.startTest();
        try {
        Insight__c insightRec=[SELECT Id from Insight__c WHERE Name='Test-BusinessValuePercentage' LIMIT 1];
        List<Opportunity> oppRecords=[SELECT Id from Opportunity WHERE Name Like'Test-BusinessValuePercentage%'];
        InsightOpportunity__c insightOpp=new InsightOpportunity__c(Insight__c=insightRec.id,BusinessValueShare__c=10,Opportunity__c=oppRecords[0].id);
        insert insightOpp;
        } catch (Exception e) {
            System.assertEquals(true, e.getMessage().contains('You cannot add insight junction records with combined percentage more than 100'));
        }
        Test.stopTest();
    }
    //Test Method to test if the value of the percentage gets changed then it should calculate
    //the percentage based on the business value share from Insight__c and update the Amount in Opportunity
   @isTest
   public static void validate_getBusinessValuePercentage_updateOpportunityAmount(){
       // InsightOpportunity__c insightOpp=new InsightOpportunity__c(Insight__c=insightRec.id,BusinessValueShare__c=30,Opportunity__c=oppRecords[0].id,Active__c=true);
       Test.startTest();
       Insight__c insightRec=[SELECT Id from Insight__c WHERE Name='Test-BusinessValuePercentage' LIMIT 1];
        
       List<InsightOpportunity__c> insightOppList=[SELECT Id,
                                                          BusinessValueShare__c,
                                                          Opportunity__c,
                                                          Insight__r.BusinessValue__c,
                                                          Active__c  
                                                    FROM InsightOpportunity__c 
                                                    WHERE Insight__c=:insightRec.Id];
        insightOppList[0].BusinessValueShare__c=30;
        update insightOppList;
        Test.stopTest(); 
       
        List<Opportunity> oppRecords=[SELECT Id,Amount from Opportunity WHERE Id=:insightOppList[0].Opportunity__c];
        System.debug(LoggingLevel.INFO, 'oppRecords===> '+oppRecords[0]);
        System.assertEquals(300, oppRecords[0].Amount);

   }
   @isTest
   public static void validate_splitBusinessValueShare_UpdateExistingBusinessValueShare(){
    Test.startTest();
    
    Insight__c insightRec=[SELECT Id from Insight__c WHERE Name='Test-BusinessValuePercentage'LIMIT 1];
    List<InsightOpportunity__c> insightOppList=[SELECT Id,BusinessValueShare__c,
                                                Opportunity__c,Insight__r.BusinessValue__c,
                                                Active__c  
                                                FROM InsightOpportunity__c WHERE Insight__c=:insightRec.id];
    insightOppList[0].Active__c=false;
    update insightOppList; 
    Test.stopTest(); 
    Map<Id, Insight__c> insightMap = new Map<Id,Insight__c>([SELECT Id,
                                                               (SELECT Id,
                                                                Active__c, 
                                                                BusinessValueShare__c 
                                                                FROM InsightOpportunities__r
                                                                WHERE Active__c = true) 
                                                         FROM Insight__c WHERE Id=:insightRec.id]);
    
    Insight__c insight = insightMap.get(insightRec.Id);

    List<InsightOpportunity__c> insightOps = insight.InsightOpportunities__r;
    System.assertEquals(1, insightOps.size());
    System.assertEquals(50, insightOps[0].BusinessValueShare__c);

    
}
@isTest
   public static void validate_updateOpportunityBasedonInsight_updateOpportunityAmount(){
    Test.startTest();
    Insight__c insightRec=[SELECT Id,BusinessValue__c from Insight__c WHERE Name='Test-BusinessValuePercentage'LIMIT 1];
    insightRec.BusinessValue__c=2000;
    update insightRec;
    Test.stopTest();
    Map<Id, Insight__c> insightMap = new Map<Id, Insight__c>
                                                   ([SELECT Id, 
                                               (SELECT Id, BusinessValueShare__c ,Opportunity__c
                                                FROM InsightOpportunities__r) 
                                                FROM Insight__c WHERE Id=:insightRec.id]);
     
     Insight__c insight = insightMap.get(insightRec.Id);
    List<InsightOpportunity__c> insightOps = insight.InsightOpportunities__r;
    
   // List<Opportunity> oppRecords=[SELECT Id,Amount from Opportunity WHERE Id=:insightOps.Opportunity__c];
     
    List<InsightOpportunity__c> insightOppList=[SELECT Id,BusinessValueShare__c,
    Opportunity__r.Amount,Insight__r.BusinessValue__c,
    Active__c  
    FROM InsightOpportunity__c WHERE Insight__c=:insightRec.id];
    for(InsightOpportunity__c insightOpp:insightOppList){
        
        if(insightOpp.BusinessValueShare__c==30){
            System.assertEquals(600, insightOpp.Opportunity__r.Amount);
        }
        if(insightOpp.BusinessValueShare__c==20){
            System.assertEquals(400, insightOpp.Opportunity__r.Amount);
        }
    }

   }

}