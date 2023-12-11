@isTest(SeeAllData=false)
public class HighValueOpportunityTest {
    
    @TestSetup
    public static void createTestData() {
        Profile prof = [SELECT Id FROM Profile WHERE Name ='Standard User'];
        User usr = new User(LastName = 'Subramaniyam',
                            FirstName = 'Test',
                            ProfileId = prof.Id,
                            Alias ='sm',
                            Email = 'malathinirmal@gmail.com',
                            Username = 'malathinirmal@gmail.com',
                            TimeZoneSidKey = 'GMT',
                            LanguageLocaleKey = 'en_US',
                            EmailEncodingKey = 'UTF-8',
                            LocaleSidKey = 'en_US');
        insert usr; 
        
        Group adminGroup = [SELECT Id FROM Group WHERE DeveloperName = 'Admins' LIMIT 1];
        
        GroupMember grpMember = new GroupMember(groupId=adminGroup.Id, UserOrGroupId = usr.Id);
        insert grpMember;     
    }
    
    @isTest
    public static void highValueOpportunity_AmountGreaterThan1M_ShareRcordCreated(){
        Test.startTest();
        Opportunity opp1 = new Opportunity(Name='HighValueOpp', 
                                           StageName = 'Prospecting',
                                           Billingcountry__c='canada',
                                           Amount=1000000,
                                           CurrencyIsoCode='USD',
                                           CloseDate = System.today());
        insert opp1;
        System.debug(LoggingLevel.INFO, 'opp1 -----'+opp1);
        Group adminGroup = [SELECT Id FROM Group WHERE DeveloperName = 'Admins' LIMIT 1];
        
        List<OpportunityShare> oppResult=[SELECT Id,OpportunityAccessLevel,UserOrGroup.Name 
                                          FROM OpportunityShare WHERE OpportunityId=:opp1.id
                                          AND UserOrGroupId=:adminGroup.Id];
        System.debug(LoggingLevel.INFO, 'oppResult -----'+oppResult);
        Test.stopTest();
        System.assertEquals(true,oppResult.size()>0);
    }
    
    @isTest
    public static void highValueOpportunity_AmountLessThan1M_ShareRcordNotCreated(){
        Test.startTest();
        Opportunity opp1 = new Opportunity(Name='HighValueOpp', 
                                           StageName = 'Prospecting',
                                           Billingcountry__c='canada',
                                           Amount=1000,
                                           CurrencyIsoCode='USD',
                                           CloseDate = System.today());
        insert opp1;
        System.debug(LoggingLevel.INFO, 'opp1 -----'+opp1);
        Group adminGroup = [SELECT Id FROM Group WHERE DeveloperName = 'Admins' LIMIT 1];
        
        List<OpportunityShare> oppResult=[SELECT Id,OpportunityAccessLevel,UserOrGroup.Name 
                                          FROM OpportunityShare WHERE OpportunityId=:opp1.id
                                          AND UserOrGroupId=:adminGroup.Id];
        System.debug(LoggingLevel.INFO, 'oppResult -----'+oppResult);
        Test.stopTest();
        System.assertEquals(true, oppResult.size()==0);
    }
    
}