@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager{
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        // grab the accountId from the end of the URL
        String accountId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')-18,request.requestURI.lastIndexOf('/'));
        System.debug(LoggingLevel.INFO, 'accountId '+accountId);
        Account result =[select Id, Name, (select Id, Name from Contacts) from account where Id =:accountId];                
        return result;
    } 
}