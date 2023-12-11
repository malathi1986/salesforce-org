@isTest
public class AddPrimaryContactTest {
    
    @testsetup
    public static void createTestData(){
        Test.setMock(HttpCalloutMock.class, new HttpMockResponse());
        List<Account> accounts = new List<Account>();
        for(Integer i=0;i<50;i++){
            Account acc = new Account(Name='Test '+i, BillingState = 'NY');
            Account acc1 = new Account(Name='Test '+i, BillingState = 'CA');
            accounts.add(acc);
            accounts.add(acc1);
        }
        insert accounts;
    }
    @isTest
    public static void AddPrimaryContact_NY_50ContactsCreated(){
        Test.setMock(HttpCalloutMock.class, new HttpMockResponse());
        Contact con = new Contact(Lastname ='Test');
        Test.startTest();
        //AddPrimaryContact add = new AddPrimaryContact(con, 'NY');
        System.enqueueJob(new AddPrimaryContact(con, 'NY'));
        Test.stopTest();
        List<Contact> newContacts = [SELECT Id FROM Contact WHERE Account.BillingState = 'NY'];
        System.assertEquals(50, newContacts.size());
    }
}