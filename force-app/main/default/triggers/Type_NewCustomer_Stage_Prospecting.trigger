trigger Type_NewCustomer_Stage_Prospecting on Opportunity (before insert) {
    opportunity[] opp=trigger.new;
    for(opportunity opr:opp)
    {
        if(opr.Type=='New Customer'){	
            opr.StageName='Prospecting';
            
        }
    }
    
}