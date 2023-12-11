@isTest(SeeAllData = false)
public class ChildRecordCountTest {
    
    @TestSetup
    public static void setupTestData(){
     
        List<Account> accountList = new List<Account>();
        
        Account accFirst = new Account(Name ='TestAccountWithNoContact', AnnualRevenue =100000);
        accountList.add(accFirst);
       
        
        Account acc = new Account(Name ='TestAccountwithContact', AnnualRevenue =100000);
        accountList.add(acc);
        
        Account acc1 = new Account(Name ='TestAccountwithOpp', AnnualRevenue =1000000);
        accountList.add(acc1);
        
        Account acc2 = new Account(Name ='TestAccountwithOpp_Con', AnnualRevenue =1000000);
        accountList.add(acc2);
        
        insert accountList;
        
        /* Account accountToBeUpdatedwith = [SELECT Id,Total_Numof_ChildRecord__c FROM Account WHERE Name ='TestAccountwithOpp' LIMIT 1];
        
        System.assertEquals(0, accountToBeUpdatedwith.Total_Numof_ChildRecord__c);*/

        Contact con = new Contact(LastName ='TestContactMalathi',AccountId = acc.Id);
        insert con;

        Opportunity opp=new Opportunity(CloseDate=system.today(),Name='TestOpportunity',StageName='Closed',AccountId = acc1.Id);
        insert opp;
        
       /* Account accountToBeUpdatedwithopp = [SELECT Id,Total_Numof_ChildRecord__c FROM Account WHERE Name ='TestAccountwithOpp' LIMIT 1];
        
        System.assertEquals(1, accountToBeUpdatedwithopp.Total_Numof_ChildRecord__c);*/
        Contact con1 = new Contact(LastName ='TestContactMalathi',AccountId = acc2.Id);
        insert con1;
        Opportunity opp1=new Opportunity(CloseDate=system.today(),Name='TestOpportunity',StageName='Closed',AccountId = acc2.Id);
        insert opp1;
        
        
    }
    
    
    @isTest
    public static void insertRecord(){
        Account acc = new Account(Name ='TestAccount', AnnualRevenue =100000);
        insert acc;
        Account modifiedAccount = [SELECT Id,Total_Numof_ChildRecord__c FROM Account WHERE Id=:acc.Id];
        System.assertEquals(0,modifiedAccount.Total_Numof_ChildRecord__c);
    }
    
    @isTest
    public static void updateRecordWithNoChildren(){
        Account acc = [SELECT Id,Total_Numof_ChildRecord__c FROM Account WHERE Name ='TestAccountWithNoContact' LIMIT 1];
        Test.startTest();
        acc.AccountNumber = '10000';
        update acc;
        Test.stopTest();
        Account updateAccount = [SELECT Id,Total_Numof_ChildRecord__c FROM Account WHERE Name ='TestAccountWithNoContact' LIMIT 1];
        System.assertEquals(0,updateAccount.Total_Numof_ChildRecord__c);
    }
    
    @isTest
    public static void updateAccountRecordWithContacts(){
        //This is to link the account with contact
        /*Account acc = [SELECT Id,Total_Numof_ChildRecord__c FROM Account WHERE Name ='TestAccount99' LIMIT 1];
Contact con = [SELECT Id FROM Contact WHERE LastName ='TestContactMalathi' LIMIT 1];
Test.startTest();
con.AccountId = acc.Id;
update con;*/
        Test.startTest();
        Account accountToBeUpdated = [SELECT Id,Total_Numof_ChildRecord__c FROM Account WHERE Name ='TestAccountwithContact' LIMIT 1];
        accountToBeUpdated.AccountNumber = '0007';
        update accountToBeUpdated;
        Test.stopTest();
        Account account1 = [SELECT Id,Total_Numof_ChildRecord__c FROM Account WHERE Name ='TestAccountwithContact' LIMIT 1];
        System.assertEquals(1,account1.Total_Numof_ChildRecord__c);
    }
    
    @isTest
    public static void updateAccountRecordWithOpportunities(){
  
        Test.startTest();
        Account accountToBeUpdatedwithopp = [SELECT Id,Total_Numof_ChildRecord__c FROM Account WHERE Name ='TestAccountwithOpp' LIMIT 1];
        accountToBeUpdatedwithopp.AccountNumber = '0007';
        update accountToBeUpdatedwithopp;
        Test.stopTest();
        Account account2 = [SELECT Id,Total_Numof_ChildRecord__c FROM Account WHERE Name ='TestAccountwithOpp' LIMIT 1];
        System.assertEquals(1,account2.Total_Numof_ChildRecord__c);
    }
    @isTest
    public static void updateAccountRecordWithOpp_Con(){
  
        Test.startTest();
        Account accountToBeUpdatedwithopp_Con = [SELECT Id,Total_Numof_ChildRecord__c FROM Account WHERE Name ='TestAccountwithOpp_Con' LIMIT 1];
        accountToBeUpdatedwithopp_Con.AccountNumber = '0007';
        update accountToBeUpdatedwithopp_Con;
        Test.stopTest();
        Account account3 = [SELECT Id,Total_Numof_ChildRecord__c FROM Account WHERE Name ='TestAccountwithOpp_Con' LIMIT 1];
        System.assertEquals(2,account3.Total_Numof_ChildRecord__c);
    }
}