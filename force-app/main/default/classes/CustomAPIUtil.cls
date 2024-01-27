public with sharing class CustomAPIUtil {
    public static Inbound_Integration_Router__mdt getCustomMetadata(String integrationName){
        return [SELECT Custom_API_Handler__c,
                        Custom_API__c,
                        DeveloperName,
                        Id,
                        Incoming_Path__c,
                        Integration_Name__c,
                        Label,
                        Language,
                        Logging_enabled__c,
                        MasterLabel,
                        NamespacePrefix,
                        QualifiedApiName,
                        Redirected_To__c,
                        Retry_Enabled__c,
                        SystemModstamp FROM Inbound_Integration_Router__mdt
                        WHERE DeveloperName =:integrationName WITH SECURITY_ENFORCED
                        LIMIT 1];
    }
}