public class RegistrationDAOManager {
    
    public List<UserRegistration__c> getUserAvailableUser(String userName){
        return [SELECT Id FROM UserRegistration__c WHERE user_name__c =:userName] ;       
    }  
    public Integer getCountOfRegisteredUsers(){
        return [SELECT count() FROM UserRegistration__c];
    }
    public List<UserRegistration__c> getRegisteredUsers(){
        return [SELECT Firstname__c,LastName__C,createddate, Email__c  FROM UserRegistration__c];
    }
}