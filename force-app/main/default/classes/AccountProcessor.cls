global class AccountProcessor {
    @future
    public static void countContacts(List<Id> accountIds){
        
        Map<Id,Account> accountMap = new Map<Id,Account> ([Select Id, Number_of_Contacts__c, (SELECT Id FROM Contacts) 
                                                           from Account where Id IN:accountIds]);
        List<Account> accountToBeUpdated = new List<Account>();
        
        List<Account> accounts = accountMap.values();
        for(Account acc : accounts){
            
            Integer count = 0;
            
            if(acc!=null && acc.contacts!=null && acc.contacts.size() > 0) {
                count = count + acc.contacts.size();
            } 
            Account accTemp = new Account(Id=acc.Id, Number_of_Contacts__c = count );
            accountToBeUpdated.add(accTemp);
        }
        
        update accountToBeUpdated;
    }
    
}