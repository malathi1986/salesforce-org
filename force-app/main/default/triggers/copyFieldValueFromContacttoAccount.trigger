trigger copyFieldValueFromContacttoAccount on Contact (after insert,after update) {
    List<Contact> contacts=trigger.new;
    List<Account> acc = new List<Account>();
    for(Contact con:contacts){
        Account a=new Account(Id=con.AccountId);
        a.CleanStatus__c =con.CleanStatus; 
        acc.add(a);  
    }
    
    if(acc.size()>0){
        update acc;
        
    }
}