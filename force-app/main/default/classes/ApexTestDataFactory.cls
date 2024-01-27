public with sharing class ApexTestdataFactory {
    /**
     * It will populate default value for all the mandatory 
     * It accepts sobject name, record count
     * 
     */
    public static List<sObject> createTestRecords(String sObjectName, Integer recordCount){
        Map<String, ObjectMetadata> objectMetadataMap = getMandatoryFields(new List<String>{sObjectName});
        
        //Account acc = new Account();
        List<SObject> recordsToInsert = new List<SObject>();
        for (Integer i = 0; i < recordCount; i++) {
            SObject sObj = Schema.getGlobalDescribe().get(sObjectName).newSObject();
            for(String fieldName : objectMetadataMap.get('sObjectName').objectMandatoryFields){
                sObj.put(fieldName, 'Test '+i);
            } 
            recordsToInsert.add(sObj); 
        }
        System.debug(LoggingLevel.INFO, 'recordsToInsert '+recordsToInsert);
        return recordsToInsert;
    }
    public static Map<String, ObjectMetadata> getMandatoryFields(List<String> sObjects){
        Schema.DescribeSobjectResult[] results = Schema.describeSObjects(sObjects);
        Map<String, ObjectMetadata> metadataMap = new Map<String, ObjectMetadata>();
        // For each returned result, get some info
        for(Schema.DescribeSobjectResult res : results) {
            
            ObjectMetadata objMetadata = new ObjectMetadata();
            List<String> mandatoryFields = new List<String>();
            Map<String, Schema.DisplayType> fieldsWithDataType = new Map<String, Schema.DisplayType>();

            for(Schema.SObjectField field : res.fields.getMap().values()){
                Schema.DescribeFieldResult fieldDescribe = field.getDescribe();
                //Mandatory field identification
                if(fieldDescribe.isCreateable() && !fieldDescribe.isNillable() && !fieldDescribe.isDefaultedOnCreate()){
                    mandatoryFields.add(fieldDescribe.getName());
                }
                //Field data type mp
                fieldsWithDataType.put(fieldDescribe.getName(), fieldDescribe.getType());
            }
            objMetadata.objectName = res.getName();
            objMetadata.objectMandatoryFields = mandatoryFields;
            objMetadata.fieldsWithDataType = fieldsWithDataType;
            metadataMap.put(res.getName(), objMetadata);
        }
        return metadataMap;
    }

    public static SObject loadDefaultTestData(String objectName){
        //Get the default record json from the custom metadata
        String defaultRecordJson = getDefaultDataFromCM(objectName);
        //Create the object instance using Scheme for a given object
        SObject sObj = Schema.getGlobalDescribe().get(objectName).newSObject();

        //Map<String, List<Schema.DescribeFieldResult>> mandatoryFields = getMandatoryFields(new List<String>{sObjectName});
        Map<String,Object> sObjMap = (Map<String,Object>)JSON.deserializeUntyped(defaultRecordJson);
        //sObj =(SObject) sObjMap.get('default');
        Map<String, ObjectMetadata> objectMetadataMap = getMandatoryFields(new List<String>{objectName});
        Map<String,Schema.DisplayType> fieldDataType = objectMetadataMap.get(objectName).fieldsWithDataType;
        
        for (String field : sObjMap.keySet()) { 
            Schema.DisplayType type = fieldDataType.get(field);
            if(String.valueOf(type) == String.valueOf(Schema.DisplayType.DATETIME)){
                //Converting sting to datetime format
                Datetime dt = DateTime.parse(String.valueOf(sObjMap.get(field)));
                sObj.put(field, dt);
            } else {
                sObj.put(field, sObjMap.get(field));
            }
        }
        return sObj; 
    }
    
    private static String getDefaultDataFromCM(String objectName){
        Apex_Test_Data_Configuration__mdt apexTestData = [SELECT Object_Name__c, 
                                                                 Default_Value__c 
                                                          FROM Apex_Test_Data_Configuration__mdt 
                                                          WHERE Object_Name__c=:objectName 
                                                          WITH SECURITY_ENFORCED];    
        return apexTestData.Default_Value__c;
    }

    public static List<SObject> loadRecordsFromStaticResources(String sObjectName, String resourceName){
        StaticResource resource = [SELECT Id, 
                                       Body 
                                FROM StaticResource 
                                WHERE Name =:resourceName 
                                WITH SECURITY_ENFORCED
                                LIMIT 1];
        String csvFileBody = resource.Body.toString();
        String[] filelines = csvFileBody.split('\n');
        //This will read the header
        String[] csvColumnHeaders = filelines[0].split(',');
        List<sObject> sObjectRecords = new List<sObject>();
        
        for (Integer i = 1; i < filelines.size(); i++) {
            String[] csvColumnvalues = filelines[i].split(',');
            SObject sObj = Schema.getGlobalDescribe().get(sObjectName).newSObject();
            for (Integer j = 0; j < csvColumnvalues.size(); j++) {
                sObj.put(csvColumnHeaders[j], csvColumnvalues[j]);
            }
            sObjectRecords.add(sObj);
        }
        return sObjectRecords;
    }

    class ObjectMetadata{
        public String objectName { get; set; }
        public List<String> objectMandatoryFields { get; set; }
        public Map<String, Schema.DisplayType> fieldsWithDataType { get; set; }
    }
}