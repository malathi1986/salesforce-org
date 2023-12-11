public with sharing class RegistrationController {
    
    public string editId{get;set;}
    //public string gender{get;set;}
    //public string address{get;set;}

    public UserRegistration__c userRegister{get;set;}
    public String userAvailability {get;set;}
    public String userTypedValueString {get;set;}
    
    public RegistrationController(){
		userRegister = new UserRegistration__c();
        userAvailability ='';
	}

    public PageReference save() {
        System.debug('Save method invoked...');
        UserRegistration__c userRegister1 = new UserRegistration__c();
        try{ 
            System.debug(LoggingLevel.INFO, 'userRegister --> '+userRegister);
            upsert userRegister;

            if(userRegister.Id!=null){
                //ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO,'Record has been saved successfully.');
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Record has been saved successfully.'));
                userRegister=new UserRegistration__c();
            }
            else{
                // ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Record has not been saved.'); 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Record has not been saved.'));
            }
        }
        catch (exception e){
            //ApexPages.addMessages(e) ; 
            system.debug(e.getMessage());
        }
        finally{
            //userRegister=new UserRegistration__c();
             
        }
        
        PageReference pg = new PageReference('/apex/userRegistrationSuccess');
        pg.setRedirect(true);
        return pg; 
        //return null;
        
        
    } 
    public List<UserRegistration__c> getUserRegList(){
        List<UserRegistration__c> UserRegList =new List<UserRegistration__c>();
        UserRegList=[SELECT Id, Name, Firstname__c, Lastname__c, Email__c, Password__c, gender__c, User_Name__c, Mobilephone__c, Address__c, state__c FROM UserRegistration__c];
        return UserRegList;
    }
    
    public PageReference edit(){
        System.debug('edit method invoked...'+ editId);
        //UserRegistration__c userRegister = new UserRegistration__c();
        userRegister=[SELECT Id, Name, Firstname__c, Lastname__c, Email__c, Password__c, gender__c, User_Name__c, Mobilephone__c, Address__c, state__c FROM UserRegistration__c WHERE Id=:editId];
        //return userRegister;
        return null;
        
    }
    
    public PageReference cancel() {
        //update account;
        return null;
    }
    
    public PageReference reset() {
        //update account;
        
        userRegister = new UserRegistration__c();
        //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.info,'Reset'));

        return null;
    }

    public Pagereference checkIfUserAvailable(){
        System.debug(LoggingLevel.INFO, 'CALLED the server method....'+ userTypedValueString);
        System.debug(LoggingLevel.INFO, 'userRegister.User_Name__c the server method....'+ userRegister.User_Name__c);
        
        List<UserRegistration__c> userNameExists = [SELECT Id FROM UserRegistration__c WHERE User_Name__c =:userTypedValueString LIMIT 1];
        if(userNameExists!=null & userNameExists.size() > 0){
            userAvailability ='User name is already taken, please choose a different name';
        } else {
            userAvailability ='User name is available';
        }
        
        return null;
    }
    
}