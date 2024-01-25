trigger change_acc_status on Opportunity (before insert, before update) {
opportunity[] opp=trigger.new;
    for(opportunity opr:opp)
    {
        if(opr.DeliveryInstallationStatus__c =='Completed'){
            Account[] acc =[SELECT ID,ACTIVE__C FROM ACCOUNT WHERE ID=:OPR.AccountId];
            acc[0].active__C = 'Yes';
            update acc[0];            
        }        
    }
}