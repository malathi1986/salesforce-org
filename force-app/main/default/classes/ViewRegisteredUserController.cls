public class ViewRegisteredUserController {
    
    public ViewRegisteredUserController(){
        RegistrationDAOManager registration = new RegistrationDAOManager();
        registeredUserList = registration.getRegisteredUsers();
        numberOfRegisteredUser=registration.getCountOfRegisteredUsers();
        
    }
    public List<UserRegistration__c> registeredUserList {get;set;}
    public Integer numberOfRegisteredUser {get;set;}
    
    public pageReference getRegisteredUsers(){

        return null;
    }
     public pageReference getCountOfRegisteredUsers(){

        return null;
    }
    
}