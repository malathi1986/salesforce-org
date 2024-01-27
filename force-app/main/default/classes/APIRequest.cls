public class APIRequest { 
    public Map<String, String> headers {get;set;}
    public String httpMethod {get;set;}
    public Map<String, String> params {get;set;}
    public String remoteAddress {get;set;}
    public String requestBody {get;set;}
    public String requestURI {get;set;}
    public String resourcePath {get;set;}
}