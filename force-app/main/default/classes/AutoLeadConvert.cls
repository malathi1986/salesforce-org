global with sharing class AutoLeadConvert implements Database.Batchable<SObject>,Schedulable {
   
   
    global Database.QueryLocator start(Database.BatchableContext ctx){
        
        BatchApexSettings__c batchOFFSET=BatchApexSettings__c.getValues(UserInfo.getProfileId());
        Integer OFFSET_TARGET= Integer.valueOf(batchOFFSET.BatchOFFSET__c);

        return Database.getQueryLocator([SELECT Id,Auto_Convert__c 

                                        FROM Lead 
                                        WHERE Auto_Convert__c = TRUE 
                                        AND IsConverted=false
                                        ORDER BY CREATEDDATE DESC
                                        OFFSET:OFFSET_TARGET
                                        ]);
    }
    global void execute(Database.BatchableContext ctx,List<Lead> leadRecords){
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        List<Database.LeadConvert> leadConverts = new List<Database.LeadConvert>();
        for(Lead leadRecord:leadRecords){
            Database.LeadConvert lc = new Database.LeadConvert();
            lc.setConvertedStatus(convertStatus.MasterLabel);
            lc.setLeadId(leadRecord.Id);
            leadConverts.add(lc);
        }
        Database.convertLead(leadConverts, true);
    }
    global void execute(SchedulableContext ctx) {

    }
    global void finish(Database.BatchableContext ctx){

    }
}