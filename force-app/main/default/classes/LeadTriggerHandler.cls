public with sharing class LeadTriggerHandler {
    public static void afterCreateorUpdate(List<Lead> newLeads, List<Lead> oldLeads) {
        
        List<Id> leadRecordIds = new List<Id>();
        for (Lead newService : newLeads) {
            leadRecordIds.add(newService.Id);
        }

        OutboundAPI outAPI = new OutboundAPI();
        outAPI.integrationName ='Partner_Lead_Integration';
        outAPI.recordIds = leadRecordIds;
        String outAPIJson = JSON.serialize(outAPI);
        //OutboundIntegrator.invokeApi(outAPIJson);
    }
}