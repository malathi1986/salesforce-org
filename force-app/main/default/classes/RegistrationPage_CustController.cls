public class RegistrationPage_CustController {
    
    public RegistrationPage_CustController(){
        userRegistration = new  UserRegistration__c();
        currentDate = String.valueOf( System.now());
    }
   
    
    public UserRegistration__c userRegistration {get; set;}
    public String usernameAvailabilityMessage {get; set;}
    public String userName {get; set;}
    public String password {get; set;}
    public Integer numberOfUsers {get; set;}
    public String reenteredPassword {get; set;}
    public String currentDate {get; set;}
    public String inputValue {get; set;}
    
    
    public PageReference getCurrentDate(){
        currentDate = String.valueOf( System.now());
        return null;        
    }
    
    public PageReference cancelRegistration(){
        return null;        
    }
    public PageReference reset(){
        PageReference pg = new pageReference(ApexPages.currentPage().getURL());
        pg.setRedirect(TRUE);
        return pg;
    }
    
    public PageReference validatePasswordPolicies(){
        System.debug(LoggingLevel.INFO, 'firstParam--->'+password);
        return null;
    }
    
    public PageReference getCountOfRegisteredUsers(){
        System.debug(LoggingLevel.INFO, 'Method called...'+System.currentTimeMillis());
        RegistrationDAOManager registration = new RegistrationDAOManager();
        numberOfUsers = registration.getCountOfRegisteredUsers();
        System.debug(LoggingLevel.INFO, 'COUNT--->'+numberOfUsers);
        return null;
    }
    
    public PageReference isUserAvailable(){
        
        System.debug(LoggingLevel.INFO, '--->'+userRegistration.User_Name__c);
        System.debug(LoggingLevel.INFO, '--->'+userRegistration.FirstName__c);
        System.debug(LoggingLevel.INFO, '--->'+userRegistration.LastName__c);
        
        if(userRegistration.User_Name__c!=null){
            RegistrationDAOManager registration = new RegistrationDAOManager();
            List<UserRegistration__c> availableUsers = registration.getUserAvailableUser(userRegistration.User_Name__c);
            if(availableUsers!=null && availableUsers.size()>0){
                usernameAvailabilityMessage = 'Username not available! Please select a differnt username';    
            }else{
                usernameAvailabilityMessage='';
            }
        }
        
        return null;
    }
    public PageReference registeruser(){
        
        try{
            insert userRegistration;
        }catch(DMLException e){
            return null;
        }
        PageReference LoginPage = Page.Registration_Success;
        LoginPage.setRedirect(true);
        return LoginPage;
    }
    
    public String text1{get;set;}
    public String text2{get;set;}
    
    public void CallMethod()
    {
        
        text2 = text1;
    } 
}