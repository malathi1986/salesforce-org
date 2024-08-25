public with sharing class AccountAggregationHandler {
    public AccountAggregationHandler() { 
    }
    
    public static void updateProductInfoOnAccount(List<Opportunity> newOpportunities, Map<Id,Opportunity> oldOpportunities){
        
        /*List<Opportunity> opportunityItems1 = [SELECT Id,AccountId, (SELECT Id FROM OpportunityLineItems) 
                                                FROM Opportunity WHERE Id IN : newOpportunities];
        List<Account> accounts =  new List<Account>();
        for (Opportunity opp : opportunityItems1) {
            accounts.add(new Account(Id=opp.AccountId, product_count__c = opp.OpportunityLineItems.size()));
        }
        
        update accounts;*/

        List<Id> accountIds = new List<Id>();
        for (Opportunity opp : newOpportunities) {
            if(oldOpportunities.get(opp.Id).StageName !=opp.StageName && opp.StageName =='Closed Won'){
                accountIds.add(opp.AccountId);
            }
        }
        Map<Id, Integer> accountProductCount = new Map<Id, Integer>();
        List<Opportunity> opportunityItems = [SELECT Id,AccountId, (SELECT Id FROM OpportunityLineItems) 
                                                FROM Opportunity WHERE AccountId IN : accountIds];
        for (Opportunity opp : opportunityItems) {
            if(accountProductCount.get(opp.AccountId)!=null){
                Integer currentCount = accountProductCount.get(opp.AccountId);
                accountProductCount.put(opp.AccountId, opp.OpportunityLineItems.size() + currentCount);
            } else {
                accountProductCount.put(opp.AccountId, opp.OpportunityLineItems.size());
            }
        }
        List<Account> accountsToBeUpdated = new List<Account>();
        for (Id accountId : accountProductCount.keySet()) {
            Account acc = new Account(Id=accountId, Product_Count__c = accountProductCount.get(accountId));
            accountsToBeUpdated.add(acc);
        }
        update accountsToBeUpdated;
    }
}