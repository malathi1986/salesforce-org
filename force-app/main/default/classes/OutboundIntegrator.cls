public with sharing class OutboundIntegrator {

    public static void invokeApiRetry(String outAPIString){
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

        OutboundAPIHandler outAPIHandler = (OutboundAPIHandler)Type.forName(integration.Custom_API_Handler__c).newInstance();
        
        if(integration.is_Http_Body_Required__c){
            httpBody = prepareHttpRequestBody(integration, outAPI, outAPIHandler);
            request.setBody(httpBody);
        }
        
        if(integration.Authentication_Required__c){
            handleAuthentication(integration, request);
        }
        CalloutVO call = new CalloutVO();

        HttpResponse response = http.send(request);
        System.debug(LoggingLevel.INFO, 'response 9'+response.getBody());
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200 || response.getStatusCode() == 201) {
            System.debug(LoggingLevel.INFO, 'response 1'+response.getBody());
            processResponse(response, integration, outAPI,outAPIHandler);
            call.calloutStatus = true;
        } else {
            call.calloutStatus = false;
        }
        Datetime endTime = Datetime.now();

        call.request = request;
        call.response = response;
        call.integration = integration;
        call.integrationName = outAPI.integrationName;
        call.outApi = outAPI;
        call.startTime=startTime;
        call.endTime=endTime;
        createIntegerationLogs(call);
    }

    @future(callout=true)
    public static void invokeApi(String outAPIString){
        invokeApiRetry(outAPIString);
    }
    private static void handleAuthentication(Integeration_Setting__mdt integrationSetting, HttpRequest request){
        Map<String, Object> tokenMap = getAccessToken(integrationSetting);
        request.setHeader('Authorization', 'Bearer '+tokenMap.get('access_token').toString());
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Content-Length', '0');
    }

    private static Map<String, Object> getAccessToken(Integeration_Setting__mdt integrationSetting){

        Http http = new Http();
        Authentication_Parameters__mdt auth = integrationSetting.Authentication_Parameters__r[0];
        //https://udhayasow-dev-ed.my.salesforce.com/services/oauth2/token?grant_type=password&client_id=3MVG9fMtCkV6eLhe6Z1RLCpHYuyKaio3dckyngdFFsuXSLHVX9mbhdiqXitEn01eSYZA3qPk2GG8MpUUIL3Co&client_secret=90326F2B33DB99822059EE2E3EEB989E02B092052358DEC1E929AFDA1349C41E&username=partner.leadintegration@gmail.com.st&password=Malathi@123JEgdROqcjVlJTvg0jkkmD8I9
        
        HttpRequest request = new HttpRequest();
        String queryParameters = '?grant_type='+auth.Grant_Type__c+'&client_id='+auth.Client_Id__c+'&client_secret='+auth.Client_Secret__c+'&username='+auth.User_name__c+'&password='+auth.Password__c;
        String endPoint = auth.Access_Token_URL__c+queryParameters;
        request.setEndpoint(endPoint);
        request.setMethod('POST');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        Map<String, Object> responseJsonMap = null;
        if(response.getStatusCode() == 200) {
            responseJsonMap = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        }  
    
        return responseJsonMap;
    }
    private static String createIntegerationLogs(CalloutVO call){
        System.debug(LoggingLevel.INFO, 'call '+call);
        Integration_Logs__c integerationLogs=new Integration_Logs__c();
        integerationLogs.ResponseStatus__c=call.response.getStatus();
        integerationLogs.OutboundAPI__c=call.integration.HttpEndpoint__c;
        integerationLogs.Start_Time__c=call.startTime;
        integerationLogs.End_Time__c=call.endTime;
        String recordIds = String.join(call.outApi.recordIds,',');
        integerationLogs.Record_Ids__c =recordIds;
        integerationLogs.Integration_name__c = call.outApi.integrationName;
        integerationLogs.Callout_Status__c = call.calloutStatus;
        insert integerationLogs;
        createAttachments(call,integerationLogs);
        return null;

    }

    private static void createAttachments(CalloutVO call, Integration_Logs__c integerationLog){
       
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
    private static String prepareHttpRequestBody(Integeration_Setting__mdt integrationSetting, OutboundAPI outApi,OutboundAPIHandler outAPIHandler){
        String jsonString = null;
        if(integrationSetting.is_Http_Body_Required__c){
            System.debug(LoggingLevel.INFO, 'Inside '+jsonString);
            jsonString = outAPIHandler.prepareJsonRequest(outApi);
        }
        System.debug(LoggingLevel.INFO, 'jsonString '+jsonString);
        return jsonString;
    }

    private static String processResponse(HttpResponse response, Integeration_Setting__mdt integrationSetting, OutboundAPI outApi, OutboundAPIHandler outAPIHandler){
        // Deserialize the JSON string into collections of primitive data types.
        //OutboundAPIHandler responseHandler = (OutboundAPIHandler)Type.forName(integrationSetting.Custom_API_Handler__c).newInstance();
        outAPIHandler.processResponse(response,outApi);
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
                        is_Http_Body_Required__c,
                        Custom_API_Handler__c,
                        (SELECT Access_Token_URL__c,
                                Client_Id__c,
                                Client_Secret__c,
                                DeveloperName,
                                User_name__c,
                                Password__c,
                                Grant_Type__c,
                                Id,
                                IntegerationSetting__c,
                                Label,
                                Language,
                                MasterLabel 
                            FROM Authentication_Parameters__r) 
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
        public Boolean calloutStatus {public set;public get;}
    }
}