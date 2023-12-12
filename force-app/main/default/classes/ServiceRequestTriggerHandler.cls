public with sharing class ServiceRequestTriggerHandler {
    public static void afterCreateorUpdate(List<Service_Request__c> newServiceRequest, List<Service_Request__c> oldServiceRequest){
        OutboundAPI outAPI = new OutboundAPI();
        outAPI.integrationName ='Car_Manufacturer_Validation';
        String outAPIJson = JSON.serialize(outAPI);
        OutboundIntegrator.invokeApi(outAPIJson);
    }
}