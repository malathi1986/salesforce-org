trigger retrict_account_updates on Account (before insert,before update) {
     Account[] accNew = Trigger.new;    
     Account[] accOld = Trigger.old;    
    for(Account acctN : accNew){
        System.debug(LoggingLevel.INFO,'acctNew-->'+acctN.Sic);
    }
    if(accOld !=null){
    for(Account acctO : accOld){
        System.debug(LoggingLevel.INFO,'acctOld-->'+acctO.sic);
    }
    }
}