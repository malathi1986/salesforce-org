trigger track_amount_on_account on Opportunity (after insert,after update,after delete) {
    
    Map<Id,Opportunity> oldOptys = Trigger.oldMap;
    List<Opportunity> newOpportunities = null;
    if(Trigger.isDelete)
        newOpportunities = System.Trigger.old;
    else if (Trigger.isInsert || Trigger.isUpdate)
        newOpportunities = System.Trigger.new;    
    
    List<Id> accIds = new List<Id>();
    for(Opportunity opr :newOpportunities){
        accIds.add(opr.accountid);
    }
    
    Map<Id, Account> accts = new Map<Id,Account>([SELECT ID,OpportunityClose__c,OpportunityOpen__c,OpportunityWon__c FROM ACCOUNT WHERE ID IN : accIds]);
    
    List<Account> acctToBeUpdate = new List<Account>();
    
    boolean closeDeduction = false;
    boolean openDeduction = false;
    boolean lostDeduction = false;
    
    for(Opportunity opr: newOpportunities){
        
        Account acc = accts.get(opr.AccountId);
        
        if(Trigger.isInsert){
            acc = UpdateAccountAmountUtil.addAmount(opr, acc);
        }else if(Trigger.isUpdate){
            Opportunity oldOpty = oldOptys.get(opr.Id);
            
            if((oldOpty.StageName != 'Closed Lost' && oldOpty.StageName != 'Closed Won') && opr.StageName == 'Closed Lost'){
                // Boolean wonAdd, Boolean openAdd,Boolean lostAdd, Boolean wonDeduct, Boolean openDeduct,Boolean lostDeduct 
                acc = UpdateAccountAmountUtil.manipulateOnChange(opr,acc,false,false, true, false,true,false);  
            }
            else if((oldOpty.StageName == 'Closed Won') && opr.StageName == 'Closed Lost'){
                // Boolean wonAdd, Boolean openAdd,Boolean lostAdd, Boolean wonDeduct, Boolean openDeduct,Boolean lostDeduct 
                acc = UpdateAccountAmountUtil.manipulateOnChange(opr,acc,false,false, true, true,false,false);  
            }
            else if((oldOpty.StageName != 'Closed Lost' && oldOpty.StageName != 'Closed Won') && opr.StageName == 'Closed won'){
                // Boolean wonAdd, Boolean openAdd,Boolean lostAdd, Boolean wonDeduct, Boolean openDeduct,Boolean lostDeduct 
                acc = UpdateAccountAmountUtil.manipulateOnChange(opr,acc,true,false, false, false,true,false);  
            }
            else if((oldOpty.StageName == 'Closed Lost') && opr.StageName == 'Closed won'){
                // Boolean wonAdd, Boolean openAdd,Boolean lostAdd, Boolean wonDeduct, Boolean openDeduct,Boolean lostDeduct 
                acc = UpdateAccountAmountUtil.manipulateOnChange(opr,acc,true,false, false, false,false,true);  
            }
            else if((oldOpty.StageName == 'Closed Won') && (opr.StageName != 'Closed Lost' && oldOpty.StageName != 'Closed Won')){
                // Boolean wonAdd, Boolean openAdd,Boolean lostAdd, Boolean wonDeduct, Boolean openDeduct,Boolean lostDeduct 
                acc = UpdateAccountAmountUtil.manipulateOnChange(opr,acc,false,true, false, true,false,false);  
            }
            else if((oldOpty.StageName == 'Closed Lost') && (opr.StageName != 'Closed Lost' && oldOpty.StageName != 'Closed Won')){
                // Boolean wonAdd, Boolean openAdd,Boolean lostAdd, Boolean wonDeduct, Boolean openDeduct,Boolean lostDeduct 
                acc = UpdateAccountAmountUtil.manipulateOnChange(opr,acc,false,true, false, false,false,true);  
            }
            
        }
        else if(Trigger.isDelete) {
            if((opr.StageName!='Closed won')&& (opr.StageName!='Closed Lost')){
                acc = UpdateAccountAmountUtil.manipulateOnChange(opr,acc,false,false, false, false,true,false);  
                
            }
            if(opr.StageName=='Closed won'){
                acc = UpdateAccountAmountUtil.manipulateOnChange(opr,acc,false,false, false, true,false,false); 
                
            } 
            if(opr.StageName=='Closed Lost'){
                acc = UpdateAccountAmountUtil.manipulateOnChange(opr,acc,false,false, false, false,false,true); 
                
            } 
        }
        if(acc!=null)
            acctToBeUpdate.add(acc);
        
        
    }
    
    if(acctToBeUpdate!=null && acctToBeUpdate.size() > 0){update acctToBeUpdate;}
    
}