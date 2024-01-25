trigger Type_ExistingCustomer_upgrade_stage_closed_won on Opportunity (before insert,before update) {
    opportunity[] opp= trigger.new;
    for(opportunity opr :opp)
    {
        if(opr.type=='Existing Customer - Upgrade'){
            opr.StageName='Closed Won';
            
        }
        
    }

}