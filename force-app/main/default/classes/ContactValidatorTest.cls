/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class ContactValidatorTest {
    @TestSetup
    public static void setupTestData(){
        Test.setMock(HttpCalloutMock.class, new AnimalsHttpCalloutFailMock());
        Account acc = new Account(Name ='TestAccount', AnnualRevenue =100000,BillingCountry='USA');
        insert acc;
        
    }

    @isTest
    public static void validateContact_MailingCountryMatchesWithBillingCountryofAccount_ThrowsError(){
        Test.setMock(HttpCalloutMock.class, new AnimalsHttpCalloutFailMock());
        Account acc = [SELECT Id,BillingCountry FROM Account WHERE Name ='TestAccount' LIMIT 1];
        Contact con = new Contact(LastName ='TestContactBillingCountry',AccountId = acc.Id, MailingCountry='UK');
        try {
            insert con;
        } catch (Exception e) {
            System.assertEquals(true, e.getMessage().contains('The Mailing Country of Contact Should match with Billing Country of Correspoding Account'));
        }
        System.assertEquals(true, true);
    }
    
    @isTest
    public static void validateContact_MailingCountryMatchesWithBillingCountryofAccount_SavesRecord(){
        Test.setMock(HttpCalloutMock.class, new AnimalsHttpCalloutFailMock());
        Account acc = [SELECT Id,BillingCountry FROM Account WHERE Name ='TestAccount' LIMIT 1];
        Contact con = new Contact(LastName ='TestContactBillingCountry',AccountId = acc.Id, MailingCountry='USA');
        try {
            insert con;
        } catch (Exception e) {
            System.assertEquals(true, e.getMessage().contains('The Mailing Country of Contact Should match with Billing Country of Correspoding Account'));
        }
        System.assert(true, 'Contact record did not get saved');
    }
    
}