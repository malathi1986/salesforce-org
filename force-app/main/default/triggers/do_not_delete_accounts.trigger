trigger do_not_delete_accounts on Account (before delete) {
 Account[] acc = Trigger.old;    
    for(Account acct : acc){
        acct.addError('You are not authorized to delete any accounts.');
    }
    
}