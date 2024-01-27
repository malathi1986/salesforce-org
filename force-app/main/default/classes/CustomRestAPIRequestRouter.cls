@RestResource(urlMapping='/mortgage/sales')
global with sharing class CustomRestAPIRequestRouter {
    
    @HttpGet
    global static void getRecord(){
        Map<String,String> params = RestContext.request.params;
        Blob responseBody = null;
        Integer responseCode = 200;
        if(RestContext.request.headers.get('API-Name')==null){
            System.debug(LoggingLevel.INFO, 'params '+params);
            Id recordId = Id.valueOf(params.get('Id'));
            String sObjName = recordId.getSObjectType().getDescribe().getName();
            String query = 'SELECT Id, Name FROM '+sObjName +' WHERE Id =\''+recordId+'\'';
            List<SObject> queryResults = Database.query(String.escapeSingleQuotes(query));
            responseBody = Blob.valueOf(JSON.serialize(queryResults));
        }else {
            String integrationName = RestContext.request.headers.get('API-Name');
            Inbound_Integration_Router__mdt intMdt = CustomAPIUtil.getCustomMetadata(integrationName);
            InboundAPIHandler inboundHandler = (InboundAPIHandler)Type.forName(intMdt.Custom_API_Handler__c).newInstance();
            APIRequest api = new APIRequest();
            api.headers = RestContext.request.headers;
            api.params = RestContext.request.params;
            APIResponse res = inboundHandler.getRecords(api);
            responseBody = res.responseBody;
            responseCode = res.statusCode;
        }
        RestContext.response.responseBody = responseBody;
        RestContext.response.statusCode = 200;
    }

    @HttpPost
    global static void createRecord(){
        Map<String,String> params = RestContext.request.params;
        Blob responseBody = null;
        Integer responseCode = 200;
        if(RestContext.request.headers.get('API-Name')==null){
            Blob requestJsonBlob = RestContext.request.requestBody;
            SObject recordToInsert = (SObject) JSON.deserializeUntyped(String.valueOf(requestJsonBlob));
            try {
                Database.SaveResult saveRes = Database.insert(recordToInsert);
                responseBody = Blob.valueOf('Record has been created successfully');    
            } catch (Exception e) {
                responseBody = Blob.valueOf('Record has not been created successfully');    
            }
        }else {
            String integrationName = RestContext.request.headers.get('API-Name');
            Inbound_Integration_Router__mdt intMdt = CustomAPIUtil.getCustomMetadata(integrationName);
            InboundAPIHandler inboundHandler = (InboundAPIHandler)Type.forName(intMdt.Custom_API_Handler__c).newInstance();
            APIRequest api = new APIRequest();
            api.headers = RestContext.request.headers;
            api.params = RestContext.request.params;
            APIResponse res = inboundHandler.getRecords(api);
            responseBody = res.responseBody;
            responseCode = res.statusCode;
        }
        RestContext.response.responseBody = responseBody;
        RestContext.response.statusCode = 200;
    }

    @HttpPut
    global static String updateCompleteRecord(){
        String json = '{"Name":"Malathi"}';
        return json;
    }

    @HttpPatch
    global static String updateSpecificFields(){
        String json = '{"Name":"Malathi"}';
        return json;
    }

    @HttpDelete
    global static String deleteRecords(){
        String json = '{"Name":"Malathi"}';
        return json;
    }
}