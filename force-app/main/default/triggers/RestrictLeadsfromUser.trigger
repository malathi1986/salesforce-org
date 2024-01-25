trigger RestrictLeadsfromUser on Lead (before insert) {
  List<Lead> newLeads=trigger.new;
    /*for(Lead newLead:newLeads){
        Integer leadCount= [SELECT count() FROM Lead];
        if(leadCount>3){
    
           newLead.addError('Cannot insert more than 10 lead records');
       
    }
    }  */ 
}