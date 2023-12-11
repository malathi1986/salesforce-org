@isTest
public class AccountValidatorTest {

    @TestSetup
    public static void setupTestData(){
        List<Account> accounts = new List<Account>();    
        for(Integer i=0;i<5;i++){
            Account acc = new Account(Name='Test'+i);
            accounts.add(acc);
        }
        insert accounts;

        List<sObject> ls = Test.loadData(Account.sObjectType, 'AccountTestData2');
        System.assertEquals(10, ls.size());
    }
    
    @isTest
    public static void validateAccount_NoAnnualRevenueAndNumberOfEmployees_ReturnsInvalid(){
        List<Account> accounts = [SELECT Id,AnnualRevenue,NumberOfEmployees FROM Account WHERE Name LIKE 'Test%'];
        String outcome = AccountValidator.validateAccount(accounts);
        Assert.areEqual('invalid', outcome);
    }
    
    @isTest
    public static void validateAccount_AnnualRevenueAndNumberOfEmployees_Returnsvalid(){
        List<Account> accounts = [SELECT Id,AnnualRevenue,NumberOfEmployees FROM Account WHERE Name LIKE 'Test%'];
        for(Account acc : accounts){
            acc.AnnualRevenue = 1000;
            acc.NumberOfEmployees = 10;
        }
        String outcome = AccountValidator.validateAccount(accounts);
        Assert.areEqual('valid', outcome);
    }
    
    

}