@isTest
public class AccountManagerTest {
    @isTest static void getAccount() {
        Test.setMock(HttpCalloutMock.class, new AnimalsHttpCalloutFailMock());
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.my.salesforce.com/services/apexrest/Accounts/'
            + recordId+'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        // Verify results
        System.assert(thisAccount != null);
        System.assertEquals('Test record', thisAccount.Name);
    }
   static Id createTestRecord() {
        // Create test record
        Account accountTest = new Account(Name='Test record');        
        insert accountTest;
        return accountTest.Id;
}
}