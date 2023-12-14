public with sharing class VechicleOutboundAPIResponseHandler extends OutboundAPIResponseHandler{
    public override String processResponse(HttpResponse response,OutboundAPI outApi){
        Map<String, Object> responseJson = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        
        //Map<String,object> getResult = (Map<String,object>) meta.get('result');
        List<Object> results = (List<Object>) responseJson.get('Results');  
       
        Map<Id, Service_Request__c> serviceRecordsToUpdate = new Map<Id, Service_Request__c>();
        Map<Id,Service_Request__c> recordMap =  new Map<Id,Service_Request__c>([SELECT Id,Name, Vehicle_Manufacturer_Name__c FROM Service_Request__c WHERE Id IN : outApi.recordIds]);
        for(Object obj:results) {
            for(Id recordId:recordMap.keySet()){
                String vechicleManufactorName = recordMap.get(recordId).Vehicle_Manufacturer_Name__c;
                Map<String,Object> resultsdata = (Map<String,Object>)obj;
                List<Object> vehicleTypesresults = (List<Object>) resultsdata.get('VehicleTypes'); 
                String vechicleTypes = '';
                /*
                "VehicleTypes": [
                        {
                        "IsPrimary": false,
                        "Name": "Passenger Car"
                        },
                        {
                        "IsPrimary": false,
                        "Name": "Multipurpose Passenger Vehicle (MPV)"
                        }
                    ]
                */
                for(Object vehicleObj:vehicleTypesresults ){
                    /*
                    {
                        "IsPrimary": false,
                        "Name": "Multipurpose Passenger Vehicle (MPV)"
                        }
                    */ 
                    Map<String,Object> vehicleResultsdata = (Map<String,Object>)vehicleObj;
                    vechicleTypes = vechicleTypes + ';' + vehicleResultsdata.get('Name').toString(); 
                           
                }

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