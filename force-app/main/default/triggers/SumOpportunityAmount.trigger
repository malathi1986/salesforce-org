trigger SumOpportunityAmount on Opportunity (after insert,after update) {
    Set<Id> acctIds=new Set<Id>(); 
    for(Opportunity opp:Trigger.new){
        acctIds.add(opp.AccountId);
    }
    List<Account> accounts = [SELECT Id, (SELECT Id, Amount FROM Opportunities) FROM Account WHERE Id IN : acctIds];
    List<Account> accstoBeUpdated = new List<Account>();
    
    for(Account acc : accounts){
        Account updateAcc = null;
        Decimal oppAmountTotal = 0;
        
        for(Opportunity opp : acc.Opportunities){
            oppAmountTotal = oppAmountTotal + opp.Amount;
            system.debug('Total Amount====>'+oppAmountTotal);
        }
        if(oppAmountTotal >= 1000000){
            updateAcc = new Account(Id = acc.Id,BusinessType__c='Large');
        }
        if(oppAmountTotal >= 100000 & oppAmountTotal < 1000000){
            updateAcc = new Account(Id = acc.Id,BusinessType__c='Medium');
        }
        if(oppAmountTotal < 100000){
            updateAcc = new Account(Id = acc.Id,BusinessType__c='Small');
        }
        
        
        if(acc!=null){
            accstoBeUpdated.add(updateAcc);
        }
    }
    if(accstoBeUpdated.size() > 0){
        update accstoBeUpdated;
    }
    
}