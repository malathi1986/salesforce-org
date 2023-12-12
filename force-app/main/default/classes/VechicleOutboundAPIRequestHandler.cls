public with sharing class VechicleOutboundAPIRequestHandler extends OutboundAPIRequestHandler{
    public override String prepareJsonRequest(OutboundAPI outApi){
        return '{"VechicleName":"FORD"}';
    }
}