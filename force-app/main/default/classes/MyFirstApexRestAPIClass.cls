@RestResource(urlMapping='/api/Account/*')
//@RestResource (urlMapping='https://malathi02-dev-ed.lightning.force.com/services/apexrest/api/Account/')
global with sharing class MyFirstApexRestAPIClass {
    @HttpGet
    global static List<Account> doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accRecordId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        return [SELECT Id, Name, Phone, Website FROM Account WHERE Id = :accRecordId];
        //return result;
    }
    @HttpPost
    global static String doPost(String name,String phone,String accountNumber,String website){
        Account acc=new Account();
        acc.Name=name;
        acc.Phone=phone;
        acc.AccountNumber=accountNumber;
        acc.website=website;
        insert acc;
        return acc.Id;
    }
    @HttpDelete
    global static void doDelete() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accRecordId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id, Name, Phone, Website FROM Account WHERE Id = :accRecordId];
        delete result;
    }
   
}