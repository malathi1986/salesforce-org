global with sharing class CalloutRetry implements Schedulable, Database.Batchable<SObject>,Database.AllowsCallouts {
    public CalloutRetry() {

    }

    global void execute(SchedulableContext sc) {
        CalloutRetry b = new CalloutRetry(); 
        Database.executeBatch(b);
     }

    private final String FAILED_REQUESTS = 'SELECT Callout_Status__c,Record_Ids__c,Integration_Name__c FROM Integration_Logs__c WHERE Callout_Status__c = false';

    public Database.QueryLocator start(Database.BatchableContext ctx){
        return Database.getQueryLocator(FAILED_REQUESTS);
    }

    public void execute(Database.BatchableContext ctx, List<Integration_Logs__c> records){
        for (Integration_Logs__c integration : records) {
            List<Id> recordIds = (integration.Record_Ids__c!=null)?integration.Record_Ids__c.split(','):new List<Id>();
            OutboundAPI outAPI = new OutboundAPI();
            outAPI.integrationName =integration.Integration_Name__c;
            outAPI.recordIds = recordIds;
            String outAPIJson = JSON.serialize(outAPI);
            OutboundIntegrator.invokeApiRetry(outAPIJson);
        }
    }

    public void finish(Database.BatchableContext ctx){

    }
}