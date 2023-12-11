@isTest
public class RegistrationPage_CustControllerTest {
    
    @isTest
    public static void registeruser_success(){
        
        PageReference vfRegistrationPage = Page.vf_registration_page;
        Test.setCurrentPage(vfRegistrationPage);
        
        RegistrationPage_CustController controller = new RegistrationPage_CustController();
        
        
        UserRegistration__c userRegis = new UserRegistration__c();
        userRegis.User_Name__c = 'Danga';
        controller.userRegistration = userRegis;
        
        PageReference registrationComplete = controller.registerUser();
        
        System.assertEquals('/apex/registration_success', registrationComplete.getUrl());
        
        
        
        
    }
    @isTest
    public static void registeruser_failure(){
        
        PageReference vfRegistrationPage = Page.vf_registration_page;
        Test.setCurrentPage(vfRegistrationPage);
        
        RegistrationPage_CustController controller = new RegistrationPage_CustController();
        UserRegistration__c userRegis = new UserRegistration__c();
        controller.userRegistration = userRegis;
        
        
        try{
            PageReference registrationComplete = controller.registerUser();
        }catch(Exception e){
            System.assert(e.getMessage().contains('Attemt'));            
        }
        
    }
    
}