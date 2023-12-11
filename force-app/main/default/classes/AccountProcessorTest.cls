@isTest(SeeAllData = false)
public class AccountProcessorTest {
    //static Account test = new Account(); 
    @TestSetup
    public static void setupTestData(){
        
        List<Account> accountList = new List<Account>();
        List<Id> accList = new List<Id>();
        
        Test.setMock(HttpCalloutMock.class, new HttpMockResponse());
        
        Account accFirst = new Account(Name ='TestAccountWithNoContact', AnnualRevenue =100000);
        accountList.add(accFirst);

        Account acc = new Account(Name ='TestAccountwithContact', AnnualRevenue =100000);
        accountList.add(acc); 

        insert accountList;
      
        Contact con = new Contact(LastName ='TestContactMalathi',AccountId = acc.Id);
        insert con;
    }         
    @isTest
    public static void withContact(){
        
        Test.setMock(HttpCalloutMock.class, new HttpMockResponse());
        Account modifiedAccount = [SELECT Id,Number_of_Contacts__c FROM Account WHERE Name='TestAccountwithContact'];
        List<Id> accList = new List<Id>();
        accList.add(modifiedAccount.Id);
        Test.startTest();
        AccountProcessor.countContacts(accList);
        Test.stopTest();
        System.assertEquals(null,modifiedAccount.Number_of_Contacts__c);
    } 
    @isTest
    public static void withoutContact(){
        
        Test.setMock(HttpCalloutMock.class, new HttpMockResponse());
        Account modifiedAccount = [SELECT Id,Number_of_Contacts__c FROM Account WHERE Name='TestAccountWithNoContact'];
        List<Id> accList = new List<Id>();
        accList.add(modifiedAccount.Id);
        Test.startTest();
        AccountProcessor.countContacts(accList);
        Test.stopTest();
        System.assertEquals(null,modifiedAccount.Number_of_Contacts__c);
    } 
}