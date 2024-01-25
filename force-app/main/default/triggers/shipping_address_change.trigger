trigger shipping_address_change on Account (after update) {
    List<Account> newAccount = Trigger.new;  
    List<Account> oldAccount = Trigger.old;
    lIST<aCCOUNT> accts = new List<Account>();
    
    //Map<Id,Contact> contacts  = [SELECT ID,MailingCity FROM CONTACT WHERE ACCOUNTID=:Trigger.new];
    //
    Map<Id,Account> newMap = Trigger.newMap;
    Map<Id,Account> oldMap = Trigger.oldMap;
    List<Account> modifiedAccounts = new List<Account>();         
    for(Account acc : newMap.values()){
        Account oldRecord = oldMap.get(acc.Id);
        if( acc.shippingcity != oldRecord.shippingcity ){
            modifiedAccounts.add(acc);
        }
    }
    
    List<contact> updateContact=new List<contact>();
    for(Account oA : newAccount){   
        for(Account iA: oldAccount){
            
            if( oA.id==iA.id && oA.shippingcity != iA.shippingcity){
                accts.add(oA);                
            }
            
        }
        
    }
    List<Contact> conList =[SELECT ID, MAILINGCITY,ACCOUNTID FROM CONTACT WHERE ACCOUNTID=:accts];
    for(Account acc:accts){
        for(Contact con:conList){
            if(acc.id==con.accountid){
                Contact cont=new Contact(id=con.id,mailingcity=acc.ShippingCity);
                updateContact.add(cont);
            }
        }
    }
    UPDATE updateContact;
}