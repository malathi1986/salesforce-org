/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class MyFirstApexRestAPITestClass {

    @isTest
    static void testGetMethod(){
        Account acc = new Account();
        acc.Name='Test';
        acc.AccountNumber ='12345';
        insert acc;

        
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/api/Account/'+acc.Id;
        request.httpMethod = 'GET';
        RestContext.request = request;
        List<Account> acct = MyFirstApexRestAPIClass.doGet();
        System.assert(acct [0]!= null);
        System.assertEquals('Test', acct[0].Name);
        
    }
    @isTest
    static void testPostMethod(){
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/api/Account/';
        request.httpMethod = 'POST';
        RestContext.request = request;
        String acctId=MyFirstApexRestAPIClass.doPost('Dheera','480-543-8995','2345678','www.dheera.com');
        System.assert(acctId!= null);

    }
    @isTest
    static void testDeleteMethod(){
        Account acc = new Account();
        acc.Name='Test';
        acc.AccountNumber ='12345';
        insert acc;
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/api/Account/'+acc.Id;
        request.httpMethod = 'DELETE';
        RestContext.request = request;
        MyFirstApexRestAPIClass.doDelete();
       List<Account> ListAcct = [SELECT Id FROM Account WHERE Id=:acc.id];
        System.assert(ListAcct.size() ==0);
    }
}