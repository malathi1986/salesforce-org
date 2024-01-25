public with sharing class OpportunityTriggerHandler {
    public static void afterCreateorUpdate(List<Opportunity> newOpportunities, List<Opportunity> oldOpportunities) {
        
        List<Id> opportunityRecordIds = new List<Id>();
        for (Opportunity newService : newOpportunities) {
            opportunityRecordIds.add(newService.Id);
        }

        OutboundAPI outAPI = new OutboundAPI();
        outAPI.integrationName ='Partner_Opportunity_Integration';
        outAPI.recordIds = opportunityRecordIds;
        String outAPIJson = JSON.serialize(outAPI);
        //OutboundIntegrator.invokeApi(outAPIJson);
    }
}