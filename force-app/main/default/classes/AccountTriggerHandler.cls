public with sharing class AccountTriggerHandler {
    public static void isBeforeTrigger(List<Account> newAccounts) {
        
        Map<Id, Account> accWithOpportunities= new Map<Id,Account>
                  ([SELECT Id,(SELECT Id FROM opportunities WHERE StageName='Prospecting')
                    FROM Account WHERE Id IN :newAccounts ]);

                    for(Account acc:newAccounts){
                        Account databaseAcc = accWithOpportunities.get(acc.Id);
                        List<Opportunity> opportunities=databaseAcc.Opportunities;
                        if(opportunities.size() > 5 ){
                            acc.addError('You cannot add opportunities more than 5 when it is in open stage');
                    }
        }
        /* To Check Unique name on the account while creating an account
        */
        
        List<Account> accList=[SELECT Id,Name FROM Account];
        for(Account acc:newAccounts){
            for(Account acctName:accList){
                if(acctName.Name==acc.Name){
                    acc.addError('AccountName already exist..');  
                }
            }
        }

    }

}