public with sharing class OpporunityUtility {
    
    OpporunityUtility(){
        
    }
    @AuraEnabled(cacheable=true) 
    public static String checkOpportunity(String opportunityName) {
        System.debug(LoggingLevel.INFO, 'Method invoked with argument '+opportunityName);
        List<Opportunity> opportunityNameExists = [SELECT Id FROM Opportunity WHERE Name like :opportunityName LIMIT 1];
        if(opportunityNameExists!=null & opportunityNameExists.size() > 0){     
            return 'Opportunity name already exists';
        } else {
            return 'New opportunity is created';
        }  }     
    
    @AuraEnabled(cacheable=true) 
    public static String checkAccount(String accountName) {
        System.debug(LoggingLevel.INFO, 'Method invoked with argument '+accountName);
        List<Account> accountNameExists = [SELECT Id,Name FROM Account WHERE Name like:accountName];
        if(accountNameExists!=null & accountNameExists.size() > 0){     
            return 'Account name already exists for this opportunity';
            
        } else {
              return 'New Account is created for this opportunity';
            
        }              
    }
    @AuraEnabled(cacheable=true) 
    public static Map<String,String> validateForm(String opportunityName,String accountName){

        List<Opportunity> opportunityNameExists = [SELECT Id FROM Opportunity WHERE Name like :opportunityName LIMIT 1];
        Map<String,String> message =new Map<String,String> ();

        if(opportunityNameExists!=null & opportunityNameExists.size() > 0){     
            message.put('opportunityMsg','Opportunity name already exists');
        } else {
            message.put('newopportunityMsg','New opportunity is created');
        }
      


        List<Account> accountNameExists = [SELECT Id,Name FROM Account WHERE Name like:accountName];
        if(accountNameExists==null || accountNameExists.size() == 0){     
            message.put('NoAccountMsg','Account does not exist');
            
        } else{
            message.put('NoAccountMsg','');
            message.put('AccountId',accountNameExists[0].Id);
        }

        return message;  
    }
    @AuraEnabled(cacheable=true) 
    public static List<RecordType> getRecordTypes(){
        return [SELECT Id, SobjectType,name FROM RecordType where SobjectType ='Opportunity'];
    }
}