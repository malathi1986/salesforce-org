trigger Contact_LeadSource_updateCustomerPriority on Contact (before insert,before update) {
    List<Contact> newLeadSource=trigger.new;
    
    for(contact con:newLeadSource){
        if(con.LeadSource=='web'){
            List<Account> AccttoupdateRecs =new List<Account>();
            for(Account acct:[SELECT ID,CustomerPriority__c FROM ACCOUNT WHERE ID=:con.Accountid]){
                Account acc=new Account(id=acct.id,CustomerPriority__c='High');
               AccttoupdateRecs.add(acc); 
            }
           update AccttoupdateRecs; 
        }
    }
}