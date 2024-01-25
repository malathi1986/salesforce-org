trigger AccountAddressTrigger on Account (before insert,before update, after update, after insert) {
    List<Account> newAccount = Trigger.new;
    List<Account> oldAccount = Trigger.old;
    
    for(Account acct :newAccount){
        if (acct.Match_Billing_Address__c && acct.BillingPostalCode!=Null){
            acct.ShippingPostalCode = acct.BillingPostalCode;
        }
    }
    if(Trigger.isAfter && Trigger.isInsert){ 
        List<Id> accountIds = new List<Id>();
        for(Account acc : Trigger.new){
            if(acc.AnnualRevenue > 100000) {
                BigAccountTransaction__e  bigAlert = new BigAccountTransaction__e(Account__c =''+acc.AnnualRevenue);
                // Call method to publish events
                Database.SaveResult results = EventBus.publish(bigAlert);
                accountIds.add(acc.Id);
            }
        }  
        //EmployeeCallout.fetchEmployees(accountIds);
    }
    
    
}