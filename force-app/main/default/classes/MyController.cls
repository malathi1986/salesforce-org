/*** Controller  ***/
public class MyController {
    Account account;
    
    public PageReference save() {

        if(account.NumberofLocations__c > 100){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'You can\'t add a account with location more than 100'));
            return null;
        }
        try{
            update account;
        }
        catch(DmlException ex){
            ApexPages.addMessages(ex);
        }
        return null;
    }
    
    public String getName() { 
        return 'MyController';
    }
    
    public Account getAccount() {
        if(account == null)
            account = [select id, name, numberofemployees, numberoflocations__c from Account
                       where id = :ApexPages.currentPage().getParameters().get('id')];
        System.debug(LoggingLevel.INFO, 'Input Map--->'+ApexPages.currentPage().getParameters());
        return account;
    }
}