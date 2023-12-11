public class AccountSearchController {
    
    public String searchString{get;set;}
    public List<Account> matchedAccounts{get;set;}
    
    public PageReference searchAccount(){
        String searchStr = '%'+searchString+'%';
        if(searchString=='mental')
        {
          ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please do not enter words like '+searchStr));
          System.debug(LoggingLevel.INFO, 'Thanks to my error message...');  
        }
        matchedAccounts = [SELECT Id,Name FROM Account WHERE Name LIKE :searchStr];
        return null;
        
    }

}