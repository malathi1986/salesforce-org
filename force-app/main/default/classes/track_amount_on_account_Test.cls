@isTest
public class track_amount_on_account_Test {
    @TestSetup
    public static void testSetup(){
 
        Account acc = new Account(Name='Test-account-002',AnnualRevenue =100);
        insert acc;
        
        Opportunity oppr = new Opportunity(name ='deleteOppr',closedate=System.today(), StageName='Prospecting',amount=5000,accountid=acc.id);
        insert oppr; 
    }    
    @isTest
    public static void testInsert(){
        Account acc = new Account(Name='Test-account-001',AnnualRevenue =100);
        insert acc;
        
        Opportunity oppr = new Opportunity(name ='Test-oppr',closedate=System.today(), StageName='Prospecting',amount=5000,accountid=acc.id);
        insert oppr;
        
        Account acc1 = [SELECT ID, OpportunityOpen__c FROM ACCOUNT WHERE NAME='Test-account-001'];
        System.assertEquals(true, acc1.OpportunityOpen__c == 5000);
    }
    
    @isTest
    public static void testUpdate(){
        Account acc = new Account(Name='Test-account-001',AnnualRevenue =100);
        insert acc;
        
        Opportunity oppr = new Opportunity(name ='Test-oppr',closedate=System.today(), StageName='Prospecting',amount=5000,accountid=acc.id);
        insert oppr;
        
        oppr.StageName = 'Closed Lost';
        update oppr;
        
        Account acc1 = [SELECT ID, OpportunityClose__c,OpportunityOpen__c FROM ACCOUNT WHERE NAME='Test-account-001'];
        System.assertEquals(true, acc1.OpportunityClose__c == 5000);
        System.assertEquals(true, acc1.OpportunityOpen__c == 0);
    }
    
    @isTest
    public static void testUpdate1(){
        Account acc = new Account(Name='Test-account-001',AnnualRevenue =100);
        insert acc;
        
        Opportunity oppr = new Opportunity(name ='Test-oppr',closedate=System.today(), StageName='Prospecting',amount=5000,accountid=acc.id);
        insert oppr;
        
        oppr.StageName = 'Closed Won';
        update oppr;
        
        Account acc1 = [SELECT ID, OpportunityWon__c,OpportunityOpen__c FROM ACCOUNT WHERE NAME='Test-account-002'][0];
        System.assertEquals(true, acc1.OpportunityWon__c == 0);
        System.assertEquals(true, acc1.OpportunityOpen__c == 0);
    }
    @isTest
    public static void testDelete(){
        Opportunity oppr = [SELECT ID,NAME FROM OPPORTUNITY WHERE NAME ='deleteOppr'][0] ;       
        System.debug('oppr>>>>>'+oppr);
        try{delete oppr;} catch(DMLException e){
            System.debug('e---->'+e.getMessage());
        }
        
        
        Account acc1 = [SELECT ID, OpportunityClose__c,OpportunityOpen__c FROM ACCOUNT WHERE NAME='Test-account-002'];
        System.debug('===>'+acc1.OpportunityOpen__c);
        System.assertEquals(true, acc1.OpportunityOpen__c == 0);
    }
}