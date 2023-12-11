public with sharing class UserRegistrationAura {
    
    @AuraEnabled(cacheable=false) 
    public static List<UserRegistration__c> registerUser(String firstName, 
                                      String lastName, 
                                      String primaryEmail, 
                                      String secondaryEmail, 
                                      String userName, 
                                      String password, 
                                      String address){

        try {
            System.debug(LoggingLevel.INFO, 'firstName --->'+ firstName);

            UserRegistration__c userRegister = new UserRegistration__c();
            
            userRegister.Firstname__c = firstName;
            userRegister.Lastname__c = lastName;
            userRegister.Email__c = primaryEmail;
            //userRegister.secondaryEmail__c = secondaryEmail;
            userRegister.User_Name__c = userName;
            userRegister.Password__c = password;
            //userRegister.User_Name__c = userName;
            System.debug(LoggingLevel.INFO, 'userName----'+userName);
            upsert userRegister User_Name__c;
            //return 'Success';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }  
        
        return [SELECT Id, Name, Firstname__c, Lastname__c, Email__c, Password__c, gender__c, User_Name__c, Mobilephone__c, Address__c, state__c FROM UserRegistration__c];
    }

    @AuraEnabled
    public static string registerUserWithInformation(){
        try {
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return 'success';
    }

    @AuraEnabled
    public static string validateIfUserNameExists(String userName){

        List<UserRegistration__c> userNameExists = [SELECT Id FROM UserRegistration__c WHERE User_Name__c =:userName LIMIT 1];
        if(userNameExists!=null & userNameExists.size() > 0){
            //throw new AuraHandledException('Unable to process your request');
            return 'User name is already taken, please choose a different name';
        } else {
            return 'User name is available';
        }
        
        
        //return null;
    }

    @AuraEnabled(cacheable=false)
    public static List<UserRegistration__c> getAllUserRegistrations(){
        try {
            return [SELECT Id, Name, Firstname__c, Lastname__c, Email__c, Password__c, gender__c, User_Name__c, Mobilephone__c, Address__c, state__c FROM UserRegistration__c];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string deleteUserRegistrations(String[] userRegistrationIds){
        try {
            List<UserRegistration__c> recordsToBeDeleted = new List<UserRegistration__c>();
            for (String recordId : userRegistrationIds) {
                UserRegistration__c userRegistration = new UserRegistration__c(Id=recordId);
                recordsToBeDeleted.add(userRegistration);   
            }
            delete recordsToBeDeleted;
            return 'successfully deleted';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}