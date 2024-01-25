trigger ChildRecordCount on Account (before insert,before update,before delete) {
    
    if(!TriggerRegulator.firstRun){
        return;
    }
    
    List<String> fieldsList = new List<String>();
    fieldsList.add('AccountNumber');
    Boolean isAccountNumberChanged = SObjectUtil.isRecordChanged(trigger.newMap, Trigger.oldMap, fieldsList);
    if(isAccountNumberChanged){
        System.debug('Account number cannot be changed..');
    }
    
    //Map<Id,Account> newAccountsMap = Trigger.newMap;
    List<Account> conRecs=new List<Account>();
    
    List<Account> modifiedAccounts = Trigger.New;
    Map<Id, Account> oldAccountMap = Trigger.oldMap;
    List<Id> accountIdsList = new List<Id>();
    
    Boolean isTotalNumberOfRecordsUpdated = false;
    for(Account acc : modifiedAccounts){
        
   
        if(acc.Total_Numof_ChildRecord__c != oldAccountMap.get(acc.Id).Total_Numof_ChildRecord__c){
            isTotalNumberOfRecordsUpdated = true;
        }
        accountIdsList.add(acc.Id);
    }
    
    //Future method invocation
    /*if(!System.isFuture()) {
    AccountFutureHandler.calculateChildCount(accountIdsList);
    }*/
   
    //Queueable Invocation
    if(!System.isFuture()) {
    System.enqueueJob(new AccountChildCountQueueable(modifiedAccounts));
    }
/*    Map<Id,Account> accountMap = new Map<Id,Account> ([Select Id, Total_Numof_ChildRecord__c, 
                                                       (Select Id from Contacts),
                                                       (select Id from Opportunities)
                                                       from Account where Id IN:Trigger.New]);
    
    for(Account accTemp : modifiedAccounts){
        
        Account acc = accountMap.get(accTemp.Id);
        
        Integer count = 0;
        
        if(acc!=null && acc.contacts!=null && acc.contacts.size() > 0) {
            count = count + acc.contacts.size();
        }    
        if(acc!=null && acc.Opportunities!=null && acc.Opportunities.size() > 0) {
            count = count + acc.Opportunities.size();
        }
        accTemp.Total_Numof_ChildRecord__c = count;
    }*/
    
    
 /*    List<Account> accounts = [Select Id, Total_Numof_ChildRecord__c, 
                              (Select Id from Contacts),
                              (select Id from Opportunities)
                              from Account where Id IN:Trigger.New];
    
   for(Account acc:accounts){
        
        Integer count = 0;
        if(acc.Total_Numof_ChildRecord__c!=null){
            count  = Integer.valueOf(acc.Total_Numof_ChildRecord__c);
        }
        
        if(acc.contacts!=null && acc.contacts.size() > 0) {
            count = count + acc.contacts.size();
        }    
        if(acc.Opportunities!=null) {
            count = count + acc.Opportunities.size();
        }
        
        Account acct = new Account(id=acc.id,Total_Numof_ChildRecord__c=count);
        conRecs.add(acct);
    }
    TriggerRegulator.firstRun = false;
    update conRecs;*/
}