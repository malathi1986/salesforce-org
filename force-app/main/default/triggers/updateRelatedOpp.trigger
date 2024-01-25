trigger updateRelatedOpp on Account (after insert,after update) {
    List<Opportunity> Opportunities = new List<Opportunity>();
    if(trigger.isInsert){
        for(Account acc:trigger.new)  {
           Opportunity newOpportunity = new Opportunity(Name = acc.Name+' Opp',
                                                        AccountId = acc.Id,
                                                        StageName = 'Prospecting', 
                                                        Amount = 0, 
                                                        CloseDate = System.today() + 90);
              Opportunities.add(newOpportunity);
        }
    
      insert opportunities; 
    }
    if(trigger.isUpdate){
        Map<Id,Account> accts=new Map<Id,Account>();
        accts=trigger.newMap;
        //Opportunity relatedOppsforAcc=[Select AccountId,Name,StageName from Opportunity Where AccountId in: accts.keyset()];
        
        
    }
        
}