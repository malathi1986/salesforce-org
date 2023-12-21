public with sharing class PartnerLeadOutboundAPIHandler extends OutboundAPIHandler {
    
    public override String setCustomHeaders(HttpRequest request){
      return null;
    }
    public override String prepareJsonRequest(OutboundAPI outAPi){
      /**
       * 
       * {
"records" :[{
    "attributes" : {"type" : "Lead", "referenceId" : "12312381739812312"},
    "LastName" : "SampleAccount",
    "Company" : "1234567890"
    },{
    "attributes" : {"type" : "Lead", "referenceId" : "2342342342342342343"},
    "LastName" : "SampleAccount2",
    "Company" : "1234567890"
     }]
}
       */
      System.debug(LoggingLevel.INFO, 'prepareJsonRequest outAPi ------'+outAPi);
      List<Lead> leads = [SELECT Id,LastName, Company FROM Lead WHERE Id IN : outAPi.recordIds];
      //{"LastName":"Malalthi","Company" : "ABC"}
      Integer refId = 100000;
      String json = '{"records" :[';
      for (Lead ld : leads) {
        //{"LastName":"Malalthi","Company" : "ABC"}
        json = json + '{'
            +'"attributes" : {"type" : "Lead", "referenceId" : "'+refId+'"},'
            +'"LastName" : "'+ld.LastName+'",'
            +'"Company" : "'+ld.Company+'"'
            +'}';
            refId++;
      }
      json = json + ']}';
      return json;
    }
    public override String processResponse(HttpResponse response, OutboundAPI outApi){
      return null;
    }

}