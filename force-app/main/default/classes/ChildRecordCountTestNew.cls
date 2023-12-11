@isTest(SeeAllData = false)
public class ChildRecordCountTestNew {
    
    @TestSetup
    public static void setupTestData(){
        
        List<Account> testAccounts = Test.loadData(Account.sobjectType, 'AccountTestDataNew');
        
        System.debug('testAccounts--->'+testAccounts);   
        
    }
    
    @isTest
    public static void testMethod1(){
        
    }
    
}