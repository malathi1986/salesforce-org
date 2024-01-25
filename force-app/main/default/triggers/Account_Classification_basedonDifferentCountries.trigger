trigger Account_Classification_basedonDifferentCountries on Contact (after insert,after update) {
    //get list of contacts from trigger.new
    List<Contact> newContact=Trigger.new;
    //Identify the associated accounts
    Set<Id> accountsId = new Set<Id>();
    for(Contact con:newContact){
        accountsId.add(con.AccountId);
    }
    //Fetch all the contact records linked to the above accounts
    List<Account> accounts = [SELECT Id, (Select MailingCountry FROM Contacts) FROM Account WHERE Id IN:accountsId];
    List<Account> accountsToUpdated = new List<Account>();
    
    for(Account acc : accounts){
       Set<String> uniqueCountries = new Set<String>();
       List<Contact> childContacts = acc.Contacts;
        system.debug('Number of child contacts for the account===>'+childContacts);
        for(Contact con : childContacts){
            uniqueCountries.add(con.MailingCountry);
        } 
        if(uniqueCountries.size() > 5) {
            Account accToBeUpdate = new Account(Id=acc.Id, Account_Classification__c ='Sufficient');  
            accountsToUpdated.add(accToBeUpdate);
        }
        else if(uniqueCountries.size() > 3 && uniqueCountries.size()<=5) {
            Account accToBeUpdate = new Account(Id=acc.Id, Account_Classification__c ='Moderate');  
            accountsToUpdated.add(accToBeUpdate);
        }
         else if(uniqueCountries.size()<3 ) {
            Account accToBeUpdate = new Account(Id=acc.Id, Account_Classification__c ='low ');  
            accountsToUpdated.add(accToBeUpdate);
        }
    }
    update accountsToUpdated;
}