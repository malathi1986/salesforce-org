@isTest
public class Test_ApexErrorMessage {

    @testSetup
    public static void loadAccountTestData(){
        List<Account> acctList = Test.loadData(Account.sobjectType, 'AccountTestData');
        System.debug(LoggingLevel.INFO, 'acctList--->'+acctList);
    }
    
    @isTest
    public static void testmethod1(){
        
    }
}