public with sharing class ContactTriggerHandler {
    public static void contactTrigger(List<Contact> newContacts) {
        Set<Id> accountIds = new Set<Id>();
        for (Contact contact : newContacts) {
            accountIds.add(contact.AccountId);
        }
        Map<Id, Account> accountsMap = new Map<Id,Account>([SELECT Id,BillingCountry FROM Account WHERE Id IN:accountIds]);
        for(Contact con : newContacts){
            Account acc = accountsMap.get(con.AccountId);
            if(acc.BillingCountry!=con.MailingCountry ){
                con.addError('The Mailing Country of Contact Should match with Billing Country of Correspoding Account');
            }
        }
    }
}