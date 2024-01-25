trigger restrictChildcontact on Contact (before insert,before update) {
    List<Contact> newContacts= trigger.new;
    Set<Id> accountIds = new Set<Id>();
    for(Contact con:newContacts){
        accountIds.add(con.AccountId);
    }
    List<Account> accounts=[SELECT Id,(SELECT Id from Contacts) FROM Account WHERE Id IN:accountIds];
    
    for(Contact con: newContacts){
        for(Account acc: accounts){
            List<Contact> childContacts=acc.Contacts;
            System.debug(LoggingLevel.INFO, 'childContacts.size >>>>>>'+childContacts.size());
            if(con.AccountId == acc.Id) {
                if(childContacts.size() >= 5){
                    con.addError('You cannot add more than 5 Contacts to an Account ');            
                }  
            } 
        }
    }
    
    Map<Id, Account> accountsMap= new Map<Id,Account>([SELECT Id,(SELECT Id from Contacts) FROM Account WHERE Id IN:accountIds]); 
    for(Contact con: newContacts){
        Account acc = accountsMap.get(con.AccountId);
        if(acc.contacts.size() >= 5){
            con.addError('You cannot add more than 5 Contacts to an Account ');            
        }  
    } 
}