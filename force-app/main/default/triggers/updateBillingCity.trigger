trigger updateBillingCity on Account (after update) {
    
    Set<Id> accountIds= new Set<Id>();
    //List<Id> accountIds= new List<Id>();
    for(Account acc:Trigger.new){
        accountIds.add(acc.Id);
    }
    List<Contact> contactRecs=[SELECT Id, MailingCity, AccountId From Contact WHERE AccountId IN :accountIds];
    for(Contact con:contactRecs){
        con.MailingCity=trigger.newMap.get(con.AccountId).BillingCity;
        
    }
    update contactRecs;
}