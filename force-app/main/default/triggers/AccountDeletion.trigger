trigger AccountDeletion on Account (before delete) {
List<Account> acc=trigger.old;
    for(Account a:acc){
       List<opportunity> opp=new List<opportunity>();
        
    }
}