/*Write a trigger on Opportunity, when an Opportunity will be insert 
an Opportunity Line Item should be insert by default with any of the Product 
associated with Opportunity */

public with sharing class opportunityTriggerHandler {
    public static void isAfterTrigger(List<Opportunity> oppList) {
        Product2 prod = [SELECT Id, Name FROM Product2 LIMIT 1];
        PriceBookEntry pbe = [SELECT Id FROM PriceBookEntry LIMIT 1];
        List<OpportunityLineItem> oppItemList = new List<OpportunityLineItem>();
        for(Opportunity opp : oppList){
            OpportunityLineItem oppLineItem = new OpportunityLineItem();
            oppLineItem.Id=opp.Id;
            oppLineItem.OpportunityId = opp.Id;
            oppLineItem.PricebookEntryId = pbe.Id;
            oppLineItem.UnitPrice = 10;
            oppLineItem.Product2Id = prod.Id;
            oppLineItem.Quantity = 1;
            oppItemList.add(oppLineItem);
        }
        insert oppItemList;
}

/* Write an Apex trigger named “OpportunityTrigger” that automatically updates a 
custom field named “TotalOpportunityAmount” 
on the Account object whenever an Opportunity related to that Account is closed/won.
The custom field should contain the sum of the Amount values from all closed/won Opportunities 
associated with the Account. */
public static void updateAccountTotalOpportunityAmount(List<Opportunity> opportunities) {
    Set<Id> accoundIds=new Set<Id>();
    for(Opportunity opp:opportunities){
        accoundIds.add(opp.Id); 
    }
    List<Account> accountsRelatedToOpp=[SELECT Id,(SELECT Amount,StageName FROM Opportunities WHERE StageName = 'Closed Won')
                                        FROM Account WHERE Id IN :accoundIds];
        for(Account account:accountsRelatedToOpp) {
            decimal totalAmount=0;
            for(Opportunity opportunity:account.Opportunities){
                if(opportunity.StageName=='Closed Won'){
                    totalAmount =totalAmount+ opportunity.Amount; 

                }
                account.TotalOpportunityAmount__c=totalAmount;
            }
        } 
        update  accountsRelatedToOpp;                             
}


}