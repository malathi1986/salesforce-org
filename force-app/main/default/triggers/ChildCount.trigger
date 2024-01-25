trigger ChildCount on Contact (before insert, before update, after insert,after delete) {
    
    List<Id> accids=new List<Id>();
    for(Contact con:Trigger.new){
        accids.add(con.AccountId); 
    }
    
    if(Trigger.isInsert && Trigger.isBefore){
        for(Contact con:Trigger.new){
            if(con.Languages__c == null){
                con.Languages__c = 'English';
            }
            if(con.othercountry == null){
                con.othercountry = con.MailingCountry;
            }
            if(con.othercountry == null){
                con.othercountry = con.MailingCountry;
            }
            if(con.othercountry == null){
                con.othercountry = con.MailingCountry;
            }
        }
    }
    
    if(Trigger.isInsert && Trigger.isAfter){
        
        List<Account> accRecs=new List<Account>();
        for(Account acc:[SELECT ID,CHILDCOUNT__C FROM ACCOUNT WHERE ID=:ACCIDS]){
            Decimal count = acc.ChildCount__c;
            if(count==null){
                count =0;
            }
            Account acct = new Account(id=acc.id,ChildCount__c=count+1);
            accRecs.add(acct);
        }
        update accRecs; 
        
    }
  if(Trigger.isdelete && Trigger.isAfter){
        
        List<Account> accRecs=new List<Account>();
        for(Account acc:[SELECT ID,CHILDCOUNT__C FROM ACCOUNT WHERE ID=:ACCIDS]){
            Decimal count = acc.ChildCount__c;
            Account acct = new Account(id=acc.id,ChildCount__c=count-1);
            accRecs.add(acct);
        }
        update accRecs; 
        
    }  
}