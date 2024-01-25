trigger createNewOpp on Account (after insert,after update) {
    List<Opportunity> opportunities = new List<Opportunity>();
    for(Account acc:trigger.new){
        if(acc.Industry=='Agriculture'){
        Opportunity newOpportunity = new Opportunity(Name = acc.Name+' Opp',
                                                        AccountId = acc.Id,
                                                        StageName = 'Prospecting', 
                                                        Amount = 0, 
                                                        CloseDate = System.today() + 90);
              opportunities.add(newOpportunity);
        }
      insert opportunities;
    }
    

}