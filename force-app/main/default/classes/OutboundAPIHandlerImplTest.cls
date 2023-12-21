@isTest
public with sharing class OutboundAPIHandlerImplTest {
  @isTest
  public static void setCustomHeaders_HttpRequestPassed(){
    OutboundAPIHandlerImpl out = new OutboundAPIHandlerImpl();
    String outcome = out.setCustomHeaders(new HttpRequest());
    Assert.areEqual(null, outcome);
  } 
  public static void prepareJsonRequest_HttpRequestPassed(){
    OutboundAPIHandlerImpl out = new OutboundAPIHandlerImpl();
    String outcome = out.prepareJsonRequest(new OutboundAPI());
    Assert.areEqual(null, outcome);
  }  
  public static void processResponse_HttpRequestPassed(){
    OutboundAPIHandlerImpl out = new OutboundAPIHandlerImpl();
    String outcome = out.processResponse(new HttpResponse(),new OutboundAPI());
    Assert.areEqual(null, outcome);
  }   
}