public with sharing class ServiceRequestTriggerHandler {
    public static void afterCreateorUpdate(List<Service_Request__c> newServiceRequest, List<Service_Request__c> oldServiceRequest){
        List<Id> serviceRequestIds = new List<Id>();
        for (Service_Request__c newService : newServiceRequest) {
            serviceRequestIds.add(newService.Id);
        }
        OutboundAPI outAPI = new OutboundAPI();
        outAPI.integrationName ='Car_Manufacturer_Validation';
        outAPI.recordIds = serviceRequestIds;
        String outAPIJson = JSON.serialize(outAPI);
        OutboundIntegrator.invokeApi(outAPIJson);

    }
}