trigger Opportunity_Stages_updateAmount on Opportunity (before insert,before update) {
    List<Opportunity> newOppStage = Trigger.new;  
    //List<Opportunity> oldOppStage = Trigger.old;
    for(opportunity op:newOppStage){
        if(op.StageName!='Closed Won' && op.StageName!='Closed Lost'){
            List<Account> accRecs=new List<Account>();
            for(Account acc:[SELECT ID,OpportunityOpen__c FROM ACCOUNT WHERE ID=:op.Accountid]){ 
                Account acct = new Account(id=acc.id,OpportunityOpen__c=op.Amount);
                accRecs.add(acct);
                
            }update accRecs;
        }
        if(op.StageName =='Closed Won'){
            List<Account> accRecsWon=new List<Account>();
            for(Account acc:[SELECT ID,OpportunityWon__c FROM ACCOUNT WHERE ID=:op.Accountid]){ 
                Account acct = new Account(id=acc.id,OpportunityWon__c=op.Amount);
                accRecsWon.add(acct);
                
            }update accRecsWon;
        }
        if(op.StageName=='Closed Lost'){
            List<Account> accRecsLost=new List<Account>();
            for(Account acc:[SELECT ID,OpportunityClose__c FROM ACCOUNT WHERE ID=:op.Accountid]){ 
                Account acct = new Account(id=acc.id,OpportunityClose__c=op.Amount);
                accRecsLost.add(acct);
                
            }
           update accRecsLost; 
        } 
    }}