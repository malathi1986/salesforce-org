public with sharing class JSONUtil {
    public JSONUtil() {

    }

    public static void processJson(){
        String jsonRequest = '{"name":"John", "Amount":30, "ownerId":null}';
        Opportunity opp = (Opportunity) JSON.deserialize(jsonRequest, Opportunity.class);
        System.debug(LoggingLevel.INFO, 'opp --->'+opp);


        Map<String, Object> jsonMap = (Map<String, Object>)JSON.deserializeUntyped(jsonRequest);
        Opportunity opp1 = new Opportunity();
        for (String key : jsonMap.keySet()) {
            opp1.put(key, jsonMap.get(key));
        }

        System.debug(LoggingLevel.INFO, 'opp1 --->'+opp1);
        
        Account acc = [SELECT Id, Name, OwnerId, CreatedDate FROM Account LIMIT 1];
        String jsonStr = JSON.serialize(acc);
        System.debug(LoggingLevel.INFO, 'jsonStr --->'+jsonStr);


        Account acc2 = new Account(Name='Test', CreatedDate = System.today(), OwnerId = UserInfo.getUserId());
        String jsonStr1 = JSON.serialize(acc2);
        System.debug(LoggingLevel.INFO, 'jsonStr --->'+jsonStr1);

    }
    //This uses JSONGenerator
    public static void createJsonRequest(){
        //String jsonRequest = '{"name":"John", "Amount":30, "ownerId":null}';
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('name', 'John');
        gen.writeNumberField('Amount', 30);
        gen.writeStringField('ownerId', '');
        //
        gen.writeFieldName('address');
        gen.writeStartObject();
        gen.writeStringField('malathi', '');
        gen.writeEndObject();

        gen.writeEndObject();
        System.debug(LoggingLevel.INFO, 'gen ---->'+gen.getAsString());
    }
}