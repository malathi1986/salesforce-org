public with sharing class OutboundIntegrator {

    @future(callout=true)
    public static void invokeApi(String outAPIString){
        System.debug(LoggingLevel.INFO, 'outAPIString --> '+outAPIString);
        OutboundAPI outAPI = (OutboundAPI)JSON.deserialize(outAPIString, OutboundAPI.class);
        System.debug(LoggingLevel.INFO, 'outAPI --> '+outAPI);
        System.debug(LoggingLevel.INFO, 'outAPI.integrationName --> '+outAPI.integrationName);
        System.debug(LoggingLevel.INFO, 'outAPI.vehicleName --> '+outAPI.vehicleName);
        System.debug(LoggingLevel.INFO, 'outAPI.vehicleTypes --> '+outAPI.vehicleTypes);
        System.debug(LoggingLevel.INFO, 'outAPI.makeId --> '+outAPI.makeId);
        //Get the integration details
        Integeration_Setting__mdt integration = getIntegrationRecord(outAPI.integrationName);
        System.debug(LoggingLevel.INFO, 'integration --> '+integration);
        Http http = new Http();
        Datetime startTime= DateTime.now();
       // Time startTime= system.now();

        HttpRequest request = new HttpRequest();
        request.setEndpoint(integration.HttpEndpoint__c);
        request.setMethod(integration.http_method__c);
        request.setHeader('tracking_id', generateUniqueIdentifier());
        String httpBody = null;
        if(integration.is_Http_Body_Required__c){
            httpBody = prepareHttpRequestBody(integration, outAPI);
            request.setBody(httpBody);
        }

        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
            processResponse(response, integration, outAPI);
        } 
        Datetime endTime = Datetime.now();

        CalloutVO call = new CalloutVO();
        call.request = request;
        call.response = response;
        call.integration = integration;
        call.integrationName = outAPI.integrationName;
        call.outApi = outAPI;
        call.startTime=startTime;
        call.endTime=endTime;
        createIntegerationLogs(call);
    }
    private static String createIntegerationLogs(CalloutVO call){
        
        IntegerationLogs__c integerationLogs=new IntegerationLogs__c();
        //integerationLogs.HttpRequest__c=call.request.getBody();
        //integerationLogs.HttpResponse__c=call.response.getBody();
        integerationLogs.ResponseStatus__c=call.response.getStatus();
        integerationLogs.OutboundAPI__c=call.integration.HttpEndpoint__c;
        integerationLogs.Start_Time__c=call.startTime;
        integerationLogs.End_Time__c=call.endTime;
        insert integerationLogs;
        createAttachments(call,integerationLogs);
        return null;

    }

    private static void createAttachments(CalloutVO call, IntegerationLogs__c integerationLog){
       
        List<ContentVersion> contentVersionList = new List<ContentVersion>();

        if(call.request.getBody() !=null) {
            ContentVersion requestContentVersion = new ContentVersion();
            requestContentVersion.ContentLocation = 'S'; // S specify this document is in SF, use E for external files
            requestContentVersion.PathOnClient = 'request.txt'; // The files name, extension is very important here which will help the file in preview.
            requestContentVersion.Title = 'Request'; // Display name of the files
            String base64Content = (String)JSON.deserialize( call.request.getBody(), String.class);
            if(base64Content !=null){
                //Blob body = EncodingUtil.base64Decode(base64Content);
                requestContentVersion.VersionData = Blob.valueOf(base64Content);
                contentVersionList.add(requestContentVersion);
            }
        }
        
        if(call.response.getBody() !=null) {
            ContentVersion responseContentVersion = new ContentVersion();
            responseContentVersion.ContentLocation = 'S'; // S specify this document is in SF, use E for external files
            responseContentVersion.PathOnClient = 'response.txt'; // The files name, extension is very important here which will help the file in preview.
            responseContentVersion.Title = 'Response'; // Display name of the files
            String base64Content = (String)JSON.deserialize( call.response.getBody(), String.class);
            if(base64Content!=null){
                //Blob body = EncodingUtil.base64Decode(JSON.deserializeUntyped(call.response.getBody());
                responseContentVersion.VersionData = Blob.valueOf(base64Content);
                contentVersionList.add(responseContentVersion);
            } 
            
        }
        System.debug(LoggingLevel.INFO, 'contentVersionList ======='+contentVersionList);
        insert contentVersionList;

        List<ContentVersion> contentVersions = [SELECT ContentDocumentId FROM ContentVersion WHERE Id IN : contentVersionList];

        List<ContentDocumentLink> contentDocumentLinks = new List<ContentDocumentLink>();
        //Create ContentDocumentLink
        for (ContentVersion contentV : contentVersions) {
            ContentDocumentLink cDe = new ContentDocumentLink();
            cDe.ContentDocumentId = contentV.ContentDocumentId;
            cDe.LinkedEntityId = integerationLog.Id; // you can use objectId,GroupId etc
            cDe.ShareType = 'V'; // Inferred permission, checkout description of ContentDocumentLink object for more details
            contentDocumentLinks.add(cDe);
        }
        insert contentDocumentLinks;
    }



    private static String setHeaders(Integeration_Setting__mdt integrationSetting, HttpRequest request){
        String jsonString = null;
       if(integrationSetting.Outbound_API_Header_Handler__c!= null){
            OutboundAPIHeaderHandler setHeader = (OutboundAPIHeaderHandler)Type.forName(integrationSetting.Outbound_API_Header_Handler__c).newInstance();
            setHeader.setCustomHeaders(request);
        }
        return jsonString;
    }
    private static String prepareHttpRequestBody(Integeration_Setting__mdt integrationSetting, OutboundAPI outApi){
        String jsonString = null;
        if(integrationSetting.is_Http_Body_Required__c){
            /*OutboundAPIRequestHandler out = null;
            if(integrationSetting.DeveloperName == 'Car_Manufacturer_Validation'){
                 out = new VechicleOutboundAPIResponseHandler();
            }
            if(integrationSetting.DeveloperName == 'Animal_Validation'){
                out = new AnimalOutboundAPIResponseHandler();
           }*/
            OutboundAPIRequestHandler responseHandler = (OutboundAPIRequestHandler)Type.forName(integrationSetting.RequestHandler__c).newInstance();
            responseHandler.prepareJsonRequest(outApi);
        }
        return jsonString;
    }

    private static String processResponse(HttpResponse response, Integeration_Setting__mdt integrationSetting, OutboundAPI outApi){
        // Deserialize the JSON string into collections of primitive data types.
        OutboundAPIResponseHandler responseHandler = (OutboundAPIResponseHandler)Type.forName(integrationSetting.ResponseHandler__c).newInstance();
        responseHandler.processResponse(response,outApi);
        return null;
    }

    private static String generateUniqueIdentifier(){
        Blob b = Crypto.GenerateAESKey(128);
        String h = EncodingUtil.ConvertTohex(b);    
        String guid = h.SubString(0,8)+ '-' + h.SubString(8,12) + '-' + h.SubString(12,16) + '-' + h.SubString(16,20) + '-' + h.substring(20);
        return guid;
    }
    
    private static Integeration_Setting__mdt getIntegrationRecord(String integrationName){
        return [SELECT Authentication_Required__c,
                        Authentication__c,
                        ClientId__c,
                        ClientSecret__c,
                        DeveloperName,
                        HttpEndpoint__c,
                        http_method__c,
                        Http_Request_Timeout__c,
                        Id,
                        Label,
                        Language,
                        MasterLabel,
                        Mutual_Authentication__c,
                        NamespacePrefix,
                        QualifiedApiName,
                        RequestHandler__c,
                        ResponseHandler__c,
                        is_Http_Body_Required__c 
                FROM Integeration_Setting__mdt 
                WHERE DeveloperName =:integrationName 
                WITH SECURITY_ENFORCED
                LIMIT 1];
    }

    class CalloutVO {
        public String integrationName {public set;public get;}
        public HttpRequest request {public set;public get;}
        public HttpResponse response {public set;public get;}
        public OutboundAPI outApi {public set;public get;}
        public DateTime startTime{public set;public get;}
        public DateTime endTime{public set;public get;}
        public Integeration_Setting__mdt integration {public set;public get;}
    }
}