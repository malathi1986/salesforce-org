trigger ContactCommon on Contact (before insert, after insert, before update, after update, before delete, after delete) {
    
    List<Contact> newContacts = Trigger.new;
    List<Contact> oldContacts = Trigger.old;

    Map<Id,Contact> newContactsMap = Trigger.newMap;
    Map<Id,Contact> oldContactsMap = Trigger.oldMap;
    
    Set<Id> accountIdsToBeUpdated = new Set<Id>();

    Map<Id,Integer> accountIdsToBeUpdatedMap = new Map<Id,Integer>();

    if(Trigger.isInsert){
       System.debug(LoggingLevel.INFO, 'Insert event fired');
       if(Trigger.isAfter){
          for (Contact con : newContacts) {
            if(con.MailingCountry == 'US'){
                if(!accountIdsToBeUpdatedMap.keySet().contains(con.AccountId)){
                    accountIdsToBeUpdatedMap.put(con.AccountId, 1);
                } else {
                    Integer existingCount = accountIdsToBeUpdatedMap.get(con.AccountId);
                    accountIdsToBeUpdatedMap.put(con.AccountId, existingCount+1);
                }
            }
          }

          List<Account> accounts = [SELECT Id, Number_of_US_contacts__c          
                                    FROM Account
                                    WHERE Id =:accountIdsToBeUpdated];

          List<Account> updateList = new List<Account>();

          for(Account acc : accounts) {

            Integer numberOfCurrentUSContacts = (Integer)acc.Number_of_US_contacts__c;
            numberOfCurrentUSContacts = numberOfCurrentUSContacts + accountIdsToBeUpdatedMap.get(acc.Id);

            Account updateAccount = new Account(Id = acc.Id,Number_of_US_contacts__c =numberOfCurrentUSContacts);

            updateList.add(updateAccount);

          }

          update updateList;
       
       }

    }
    if(Trigger.isUpdate){

    }
    if(Trigger.isDelete){

    }

}