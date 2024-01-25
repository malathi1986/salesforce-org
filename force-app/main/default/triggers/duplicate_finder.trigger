trigger duplicate_finder on Lead (before insert,before update) {
    
    List<Lead> newLeads = Trigger.new;
    
    Map<id,Lead> newMap = Trigger.newMap;
    
    List<Lead> oldLeads = Trigger.old;
    
    Map<id,Lead> oldMap = Trigger.newMap;
    
   
    List<Lead> existingLeads =[SELECT LASTNAME,PHONE FROM LEAD];
    
    for(Lead oL : newLeads){
        
        for(Lead iL: existingLeads){
            
            if(oL.LastName == iL.LastName && oL.Phone == iL.Phone){
                oL.addError('Duplicate record found in the database for the combination of Last name and phone...');
            }
            
        }
        
    }
    
    
}