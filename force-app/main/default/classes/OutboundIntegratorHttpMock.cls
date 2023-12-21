global class OutboundIntegratorHttpMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"hasErrors":false,"results":[{"referenceId":"100000","id":"0063a00000nWVObAAO"}]}');
        res.setStatusCode(200);
        return res;
    }
}