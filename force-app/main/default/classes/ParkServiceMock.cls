global class ParkServiceMock implements WebServiceMock {
    global void doInvoke(
        Object stub,
        Object request,
        Map<String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType) {
            // start - specify the response you want to send
            ParkService.byCountryResponse  CountryResponse = new ParkService.byCountryResponse ();
            List<String> parkNames=new List<String>{'central Park','Lincoln Park','Roosevelt Park'};
                
            CountryResponse.return_x = parkNames;
            
            response.put('response_x', CountryResponse);
            // end
            //response.put('CountryResponse', CountryResponse);
        }
    
}