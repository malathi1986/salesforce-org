public with sharing class VechicleOutboundAPIResponseHandler extends OutboundAPIResponseHandler{
    public override String processResponse(HttpResponse response,OutboundAPI outApi){
        System.debug(Logginglevel.INFO, 'Response===>'+response);
        System.debug(Logginglevel.INFO, 'RecordIds===>'+outApi.recordIds);
        Map<String, Object> responseJson = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        System.debug(Logginglevel.INFO, 'JSONresponse===>'+responseJson);
        //Map<String,object> getResult = (Map<String,object>) meta.get('result');
        List<Object> results = (List<Object>) responseJson.get('Results');  
        System.debug(Logginglevel.INFO, 'results===>'+results); 
        Map<Id, Service_Request__c> serviceRecordsToUpdate = new Map<Id, Service_Request__c>();
        Map<Id,Service_Request__c> recordMap =  new Map<Id,Service_Request__c>([SELECT Id,Name, Vehicle_Manufacturer_Name__c FROM Service_Request__c WHERE Id IN : outApi.recordIds]);
        for(Object obj:results) {
            for(Id recordId:recordMap.keySet()){
                String vechicleManufactorName = recordMap.get(recordId).Vehicle_Manufacturer_Name__c;
                Map<String,Object> resultsdata = (Map<String,Object>)obj;
                System.debug(Logginglevel.INFO, 'Command Name ===>'+resultsdata.get('Country'));
                System.debug(Logginglevel.INFO, 'resultObject===>'+ resultsdata.get('Mfr_CommonName'));
                List<Object> vehicleTypesresults = (List<Object>) resultsdata.get('VehicleTypes'); 
                //System.debug(Logginglevel.INFO, 'VehicleTypes===>'+ resultsdata.get('VehicleTypes'));
                String vechicleTypes = '';
                for(Object vehicleObj:vehicleTypesresults ){
                    Map<String,Object> vehicleResultsdata = (Map<String,Object>)vehicleObj;
                    System.debug(Logginglevel.INFO, 'VehicleTypes===>'+ vehicleResultsdata.get('Name'));
                    vechicleTypes = vechicleTypes + ';' + vehicleResultsdata.get('Name').toString();
                    System.debug(Logginglevel.INFO, 'VehicleTypes===>'+vechicleTypes);
                }
                
               // string values = 'A;B;D';

                if(resultsdata.get('Mfr_CommonName') == vechicleManufactorName){
                    Service_Request__c serviceReq = new Service_Request__c(Id=recordId,
                     Country_Of_Origin__c = resultsdata.get('Country').toString(),
                      Vehicle_Types__c = vechicleTypes);
                    serviceRecordsToUpdate.put(recordId, serviceReq);
                }
            }
        }
        update serviceRecordsToUpdate.values();
        return null;
    }
}