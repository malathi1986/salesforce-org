@isTest
public class SumOpportunityAmountTest {
    @isTest
    public static void validateBusinessTypeonAccount_Amountgreaterthan_LargeBusinessType(){
        Test.startTest();
        Account acc = new Account(Name='TestBusinessType',AnnualRevenue =100);
        insert acc; 
        
        Opportunity oppr = new Opportunity(Name ='Test-LargeBusinessType',closedate=System.today(), 
                                           StageName='Prospecting',amount=1000000,AccountId=acc.Id);
        insert oppr;
        System.debug('oppr--->'+oppr);
        
        Account result=[SELECT id,BusinessType__c from Account WHERE Name='TestBusinessType'][0];
        System.debug('result--->'+result);
        
        System.assertEquals('Large',result.BusinessType__c);
        Test.stopTest();     
    }
    @isTest
    public static void validateBusinessTypeonAccount_AmountGreaterandLessthan_MediumBusinessType(){
        Test.startTest();
        Account acc = new Account(Name='TestBusinessType',AnnualRevenue =100);
        insert acc; 
        
        Opportunity oppr1 = new Opportunity(name ='Test-MediumBusinessType',closedate=System.today(), StageName='Closed Won',amount=100000);
        insert oppr1;
        Account result=[SELECT id,BusinessType__c from Account WHERE BusinessType__c='Medium'][0];
        System.assertEquals('Medium',result.BusinessType__c);
        Test.stopTest();
        
        
    }
    @isTest
    public static void validateBusinessTypeonAccount_Amountlessthan_SmallBusinessType(){
        Test.startTest();
        Account acc = new Account(Name='TestBusinessType',AnnualRevenue =100);
        insert acc; 
        
        Opportunity oppr2 = new Opportunity(name ='Test-smallBusinessType',closedate=System.today(), StageName='Closed Lost',amount=10000);
        insert oppr2;
        
        Account result=[SELECT id,BusinessType__c from Account WHERE BusinessType__c='Small'][0];
        System.assertEquals('Small',result.BusinessType__c);
        Test.stopTest();
    }
}