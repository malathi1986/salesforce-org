@isTest
public class UpdateAccountAmountUtil_Test {
    
    @TestSetup
    public static void setupTestData(){
        Account acc = new Account(Name='Test-account-001',AnnualRevenue =100);
        insert acc;
        
        Opportunity oppr = new Opportunity(name ='Test-oppr',closedate=System.today(), StageName='Prospecting',amount=5000);
        insert oppr;
        
        Opportunity oppr1 = new Opportunity(name ='Test-oppr1',closedate=System.today(), StageName='Closed Won',amount=5000);
        insert oppr1;
        
        Opportunity oppr2 = new Opportunity(name ='Test-oppr2',closedate=System.today(), StageName='Closed Lost',amount=5000);
        insert oppr2;
        
        
        Opportunity opprupdate = new Opportunity(name ='Test-opprupdate',closedate=System.today(),StageName='Closed Lost',amount=1000);
        insert opprupdate;
        
        Opportunity opprupdate1 = new Opportunity(name ='Test-opprupdate1',closedate=System.today(),StageName='Closed Won',amount=1000);
        insert opprupdate1;
        
        Opportunity opprupdate2 = new Opportunity(name ='Test-opprupdate2',closedate=System.today(),StageName='Prospecting',amount=1000);
        insert opprupdate2;
    }
    
    @isTest
    public static void addAmount1(){
        Test.startTest();
        Opportunity opty = [SELECT ID, NAME,StageName,amount FROM Opportunity WHERE NAME ='Test-oppr'][0];
        Account acc = [SELECT ID, NAME,OpportunityWon__c,OpportunityClose__c,OpportunityOpen__c FROM Account WHERE NAME ='Test-account-001'][0];
        
        Account acc1 = UpdateAccountAmountUtil.addAmount(opty, acc);
        System.debug('acc1--->'+acc1);
        System.assertEquals(true, acc1.OpportunityOpen__c==5000);
        Test.stopTest();
    }
    
    @isTest
    public static void addAmount2(){
        Test.startTest();
        Opportunity opty = [SELECT ID, NAME,StageName,amount FROM Opportunity WHERE NAME ='Test-oppr1'][0];
        Account acc = [SELECT ID, NAME,OpportunityWon__c,OpportunityClose__c,OpportunityOpen__c FROM Account WHERE NAME ='Test-account-001'][0];
        
        Account acc1 = UpdateAccountAmountUtil.addAmount(opty, acc);
        System.debug('acc1--->'+acc1);
        System.assertEquals(true, acc1.OpportunityWon__c==5000);
        Test.stopTest();
        
    }
    
    @isTest
    public static void addAmount3(){
        Opportunity opty = [SELECT ID, NAME,StageName,amount FROM Opportunity WHERE NAME ='Test-oppr2'][0];
        Account acc = [SELECT ID, NAME,OpportunityWon__c,OpportunityClose__c,OpportunityOpen__c FROM Account WHERE NAME ='Test-account-001'][0];
        
        Account acc1 = UpdateAccountAmountUtil.addAmount(opty, acc);
        System.debug('acc1--->'+acc1);
        System.assertEquals(true, acc1.OpportunityClose__c==5000);
    }
    
    
    @isTest
    public static void manipulateOnChange(){
        Opportunity opty = [SELECT ID, NAME,StageName,amount FROM Opportunity WHERE NAME ='Test-opprupdate'][0];
        Account acc = [SELECT ID, NAME,OpportunityWon__c,OpportunityClose__c,OpportunityOpen__c FROM Account WHERE NAME ='Test-account-001'][0];
        acc.OpportunityOpen__c = 10000;
        update acc;
        //*Opportunity opr, Account acc, Boolean wonAdd, Boolean openAdd,Boolean lostAdd, Boolean wonDeduct, Boolean openDeduct,Boolean lostDeduct
        Account acc1update=UpdateAccountAmountUtil.manipulateOnChange(opty,acc,false,false, true, false,true,false);
        System.assertEquals(true,acc1update.OpportunityClose__c==1000);
        System.assertEquals(true,acc1update.OpportunityOpen__c==9000);
        
    }
    @isTest
    public static void manipulateOnChange1(){
        Opportunity opty = [SELECT ID, NAME,StageName,amount FROM Opportunity WHERE NAME ='Test-opprupdate1'][0];
        Account acc = [SELECT ID, NAME,OpportunityWon__c,OpportunityClose__c,OpportunityOpen__c FROM Account WHERE NAME ='Test-account-001'][0];
        acc.OpportunityWon__c = 10000;
        update acc;
        //*Opportunity opr, Account acc, Boolean wonAdd, Boolean openAdd,Boolean lostAdd, Boolean wonDeduct, Boolean openDeduct,Boolean lostDeduct
        Account acc1update=UpdateAccountAmountUtil.manipulateOnChange(opty,acc,true,false, true, false,true,false);
        System.debug('acc1update--->'+acc1update);
        System.assertEquals(true,acc1update.OpportunityOpen__c==-1000);
        System.assertEquals(true,acc1update.OpportunityWon__c==11000);
    }
    @isTest
    public static void manipulateOnChange2(){
        Opportunity opty = [SELECT ID, NAME,StageName,amount FROM Opportunity WHERE NAME ='Test-opprupdate2'][0];
        Account acc = [SELECT ID, NAME,OpportunityWon__c,OpportunityClose__c,OpportunityOpen__c FROM Account WHERE NAME ='Test-account-001'][0];
        acc.OpportunityOpen__c = 10000;
        update acc;
        //*Opportunity opr, Account acc, Boolean wonAdd, Boolean openAdd,Boolean lostAdd, Boolean wonDeduct, Boolean openDeduct,Boolean lostDeduct
        Account acc1update=UpdateAccountAmountUtil.manipulateOnChange(opty,acc,false,true, false, true,false,true);
        System.debug('acc1update--->'+acc1update);
        System.assertEquals(true,acc1update.OpportunityOpen__c==11000);
        System.assertEquals(true,acc1update.OpportunityClose__c==1000 || true,acc1update.OpportunityWon__c==1000);
        
    }
}