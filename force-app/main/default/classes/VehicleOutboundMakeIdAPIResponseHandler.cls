public with sharing class VehicleOutboundMakeIdAPIResponseHandler extends OutboundAPIResponseHandler {
    public override String processResponse(HttpResponse response,OutboundAPI outApi){
        Map<String, Object> responseJson = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        System.debug(Logginglevel.INFO, 'JSONresponse===>'+responseJson);
        List<Object> results = (List<Object>) responseJson.get('Results');  
        System.debug(Logginglevel.INFO, 'results===>'+results); 
        Map<Id, Service_Request__c> serviceRecordsToUpdate = new Map<Id, Service_Request__c>();
        Map<Id,Service_Request__c> recordMap =  new Map<Id,Service_Request__c>([SELECT Id,Make_Id__c FROM Service_Request__c WHERE Id IN : outApi.recordIds]);
        for(Object obj:results) {
            for(Id recordId:recordMap.keySet()){
                String makeId = (String)recordMap.get(recordId).Make_Id__c;
                Map<String,Object> resultsdata = (Map<String,Object>)obj;
                System.debug(Logginglevel.INFO, 'Make Name ===>'+resultsdata.get('Make_Name'));
                System.debug(Logginglevel.INFO, 'resultObject===>'+ resultsdata.get('Make_ID'));
                System.debug(Logginglevel.INFO, 'Make_ID ===>'+ makeId);
                if(resultsdata.get('Make_ID')== Integer.valueOf(makeId)){
                    Service_Request__c serviceReq = new Service_Request__c(Id=recordId,
                                                                           Make_Name__c = resultsdata.get('Make_Name').toString()
                                                                          );
                    serviceRecordsToUpdate.put(recordId, serviceReq);
                }
                
            }
        }
        update serviceRecordsToUpdate.values();
        return null;
    }
}