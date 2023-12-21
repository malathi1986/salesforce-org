public abstract with sharing class OutboundAPIHandler {
    public abstract String setCustomHeaders(HttpRequest request);
    public abstract String prepareJsonRequest(OutboundAPI outAPi);
    public abstract String processResponse(HttpResponse response,OutboundAPI outApi);
}