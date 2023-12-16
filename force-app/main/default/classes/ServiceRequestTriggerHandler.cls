public with sharing class ServiceRequestTriggerHandler {
    public static void afterCreateorUpdate(List<Service_Request__c> newServiceRequest, List<Service_Request__c> oldServiceRequest){
        List<Id> serviceRequestIds = new List<Id>();
        for (Service_Request__c newService : newServiceRequest) {
            serviceRequestIds.add(newService.Id);
        }
        OutboundAPI outAPI = new OutboundAPI();
        outAPI.integrationName ='Car_Manufacturer_Validation';
        outAPI.vehicleName ='Tesla';
        outAPI.recordIds = serviceRequestIds;
        String outAPIJson = JSON.serialize(outAPI);
        OutboundIntegrator.invokeApi(outAPIJson);

        
       // Service_Request__c srvReq= new Service_Request__c();
        OutboundAPI outMakeIdAPI = new OutboundAPI();
        outMakeIdAPI.integrationName ='Car_Making_Validation';
        //outAPI.vehicleName ='Tesla';
        //outMakeIdAPI.makeId=makeIds;
        outMakeIdAPI.recordIds = serviceRequestIds;
        String outMakeIdAPIJson = JSON.serialize(outMakeIdAPI);
        OutboundIntegrator.invokeApi(outMakeIdAPIJson);


        
    }
}