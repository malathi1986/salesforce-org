trigger manage_customer_priority on Account (before insert, before update) {
    
    Account[] accNew = Trigger.new;    
    for(Account acct : accNew){
        if(acct.Rating =='Hot'){
            acct.CustomerPriority__c ='High';
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
            String[] toAddresses = new String[] {'malathinirmal@gmail.com'}; 
                mail.setToAddresses(toAddresses); 
            
            mail.setSubject('High Rish opportunity'); 
            String body = 'High Rish opportunity won'; 
            mail.setPlainTextBody(body); 
            Messaging.sendEmail(new Messaging.SingleEMailMessage[]{mail});
        }
        else{
              Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
            String[] toAddresses = new String[] {'udhayat2006@gmail.com'}; 
                mail.setToAddresses(toAddresses); 
            mail.setSubject('Low Risk opportunity'); 
            String body = 'Low Risk opportunity won'; 
            mail.setPlainTextBody(body); 
            Messaging.sendEmail(new Messaging.SingleEMailMessage[]{mail});
        }        
        
    }
}