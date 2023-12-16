global class AccountChildCountQueueable implements Queueable {
    
    public List<Account> accountsToBeProcessed = null;
    
    public AccountChildCountQueueable(List<Account> accounts){
        this.accountsToBeProcessed = accounts; 
    }
    public void execute(System.QueueableContext context){
        
        Map<Id,Account> accountMap = new Map<Id,Account> ([Select Id, Total_Numof_ChildRecord__c, 
                                                           (Select Id from Contacts),
                                                           (select Id from Opportunities)
                                                           from Account where Id IN:accountsToBeProcessed]);
        List<Account> accountToBeUpdated = new List<Account>();
        List<Account> accounts = accountMap.values();
        for(Account acc : accountMap.values()){
            Integer count = 0;
            if(acc!=null && acc.contacts!=null && acc.contacts.size() > 0) {
                count = count + acc.contacts.size();
            }    
            if(acc!=null && acc.Opportunities!=null && acc.Opportunities.size() > 0) {
                count = count + acc.Opportunities.size();
            }
            Account accTemp = new Account(Id=acc.Id, Total_Numof_ChildRecord__c = count );
            accountToBeUpdated.add(accTemp);
        }
        update accountToBeUpdated;
    }
}