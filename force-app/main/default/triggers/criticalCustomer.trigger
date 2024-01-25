trigger criticalCustomer on Contact (after insert,after update) {
    if(Trigger.isInsert){
        List<Contact> newContacts=Trigger.new;
        Set<Id> accountIds= new Set<Id>();
        
        for(Contact con:newContacts){
            accountIds.add(con.AccountId);
        }
        Map<Id, Account> accountsMap = new Map<Id,Account>([SELECT Id,AnnualRevenue FROM Account WHERE Id IN:accountIds]);
        
        List<Account> accounts = [SELECT Id,AnnualRevenue FROM Account WHERE Id IN:accountIds];
        
        for(Contact con : newContacts){
            Account acc = accountsMap.get(con.AccountId);
            if(acc.AnnualRevenue > 1000000){
                if(con.highRisk__c = false){
                    con.addError('High risk field is not selected...');
                }
            }
        }
        
        for(Contact con : newContacts){
            for(Account acc : accounts){   
                if(acc.Id == con.AccountId){
                    if(acc.AnnualRevenue > 1000000){
                        if(con.highRisk__c = false){
                            con.addError('High risk field is not selected...');
                        }
                    }
                    
                }            
            }
        }
        
        
    }
}