trigger account_active_verification on Account (before insert, before update) {
    Account[] acc = Trigger.new;
    Account[] accOld = Trigger.old;
    //List<Account> accountsToBeUpdated = new List<Account>();
    for(Account acct : acc){
        if(acct.AnnualRevenue > 10000){
            acct.Rating = 'Hot';
            //accountsToBeUpdated.add(acct);
        }
        if((acct.UpsellOpportunity__c=='Maybe' || acct.UpsellOpportunity__c=='No') && acct.Active__c =='Yes') {
            acct.addError('Since there is no opportunity, it can\'t active');
        }       
    }    
    //update accountsToBeUpdated;
}