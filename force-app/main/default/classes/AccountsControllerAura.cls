public with sharing class AccountsControllerAura {
    public AccountsControllerAura() {

    }
    @AuraEnabled
    public static List<Account> getAccounts(){
        try {

            return [SELECT Id, Name, Type, BillingCity, BillingState, Phone FROM Account LIMIT 10];
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static Account getRecord(Id recordId){
        try {
            return [SELECT Id FROM ACCOUNT WHERE Id =:recordId limit 1];
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}