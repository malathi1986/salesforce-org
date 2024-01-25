/*create a trigger on contact where if more than 5 contacts are 
 added in a account ,the older contact should be deleted automatically*/

trigger CountNumberofContacts on Contact (after insert,after update,after delete) {
    if(Trigger.isInsert){
        List<Contact> newContacts=Trigger.new;
        Set<Id> accountIds= new Set<Id>();
        for(Contact con:newContacts){
            accountIds.add(con.AccountId);
        }
        //Fetching the related accounts correspoding to the Ids fetched from the inserted contact records
        List<Account> accounts = [SELECT Id,(SELECT Id FROM Contacts ORDER BY Createddate DESC) FROM Account WHERE Id IN:accountIds];
        List<Contact> contactsTobeDeleted = new List<Contact>();
        for(Account acc : accounts){
            List<Contact> childContacts = acc.Contacts;
            system.debug(LoggingLevel.INFO, 'Number of child contacts for the account===>'+childContacts.size());
            if(childContacts.size() > 5){
                for(integer i=0;i<childContacts.size();i++) {
                    if(i>4)
                    {
                        contactsTobeDeleted.add(childContacts.get(i));   
                    }
                }
            }
        }
        delete contactsTobeDeleted;
    }
}