@isTest
public class AccountTest {

    @TestSetup
    public static void makeData(){
       User admin = [SELECT Id FROM User WHERE Profile.Name ='System Administrator' LIMIT 1]; 
       System.debug(LoggingLevel.INFO, 'admin -----'+admin);
    }
    
    @isTest
    public static void validateTest(){
        System.assertEquals(true, true);
    }
}