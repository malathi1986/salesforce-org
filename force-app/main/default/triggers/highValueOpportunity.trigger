trigger highValueOpportunity on Opportunity (after insert,after update) {
    
    //User usr = [Select Id, name from user limit 1];
    Group oppGroup = [SELECT Id FROM Group WHERE DeveloperName = 'Admins' LIMIT 1];     
    List<OpportunityShare> oppShareList = new List<OpportunityShare>();
    for(Opportunity opp:trigger.new)
    {
        if(opp.Amount >=1000000 && opp.Billingcountry__c =='canada'){
            OpportunityShare oppShare = new OpportunityShare();
            oppShare.OpportunityAccessLevel = 'Read';//The level of access the user or group should be given
            oppShare.OpportunityId = opp.Id;//The Id of the record which shpould be shared 
            oppShare.UserOrGroupId = oppGroup.Id; //The user or group Id To whom the record should be shared with
            oppShareList.add(oppShare);
        }
    }
    insert oppShareList;
}