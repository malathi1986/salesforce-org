trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {
    List<opportunity> newopp = Trigger.new; 
    List<Task> tasksToBeCreated=new List<Task>();
    
    for(opportunity opp:newopp){
        if(opp.StageName=='Closed Won'){
            Task followupTask = new Task(Subject ='Follow Up Test Task',WhatId = opp.Id);
            
            tasksToBeCreated.add(followupTask);         
        }
        
    }
    insert tasksToBeCreated;
}