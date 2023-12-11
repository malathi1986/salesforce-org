public class CustomController {
    public final Account account;
    public CustomController() {       
        account = [SELECT Id, Name, Rating, Type, Industry FROM Account 
                   WHERE Id = :ApexPages.currentPage().getParameters().get('id')];  
    }
    public Account getAccount() {
        return account;  
    }
    public PageReference save() {   
        update account;
        return null;   
    }
}