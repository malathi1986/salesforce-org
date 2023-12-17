public with sharing class PartnerOpportunityOutboundAPIHandler extends OutboundAPIHandler {
    public override String setCustomHeaders(HttpRequest request){
        return null;
      }
      public override String prepareJsonRequest(OutboundAPI outAPi){
        /**
         * 
         * {
  "records" :[{
      "attributes" : {"type" : "Opportunity", "referenceId" : "12312381739812312"},
      "Name" : "SampleOpp1",
      "CloseDate" : "2023-12-19",
      "StageName" : "Closed-won"
      },{
      "attributes" : {"type" : "Opportunity", "referenceId" : "12312381739812332"},
      "Name" : "SampleOpp2",
      "CloseDate" : "2023-12-19",
      "StageName" : "closed-Lost"
      }]
  }
         */
        System.debug(LoggingLevel.INFO, 'prepareJsonRequest outAPi ------'+outAPi);
        List<Opportunity> Opportunities = [SELECT Id,Name,CloseDate,StageName FROM Opportunity WHERE Id IN : outAPi.recordIds];
        //{"LastName":"Malalthi","Company" : "ABC"}
        Integer refId = 100000;
        String json = '{"records" :[';
        for (Opportunity opp : Opportunities) {
            Date closeDate=System.today()+30;
          //{"LastName":"Malalthi","Company" : "ABC"}
          json = json + '{'
              +'"attributes" : {"type" : "Opportunity", "referenceId" : "'+refId+'"},'
              +'"Name" : "'+opp.Name+'",'
              +'"CloseDate" : "'+opp.CloseDate.year()+'-'+opp.CloseDate.month()+'-'+opp.CloseDate.day()+'",'
              +'"StageName" : "'+opp.StageName+'"'
              +'}';
              refId++;
        }
        json = json + ']}';
        System.debug(LoggingLevel.INFO, 'json ------ '+json);
        return json;
      }
      public override String processResponse(HttpResponse response, OutboundAPI outApi){
        return null;
      }  
}