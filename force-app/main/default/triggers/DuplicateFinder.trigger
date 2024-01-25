trigger DuplicateFinder on Contact (before insert) {
    
    
    List<String> firstNames = new List<String>();
    List<String> lastNames = new List<String>();
    List<String> phones = new List<String>();
    List<String> emails = new List<String>();
    List<String> mailingPostalCodes = new List<String>();
    
    for(Contact conRec : Trigger.new){
        firstNames.add(conRec.FirstName);
        lastNames.add(conRec.LastName);
        phones.add(conRec.Phone);
        emails.add(conRec.Email);
        mailingPostalCodes.add(conRec.MailingPostalCode);
        
    }
    
    List<Contact> allContacts=[SELECT FirstName, 
                               LastName, 
                               Phone, 
                               Email, 
                               MailingPostalCode 
                               FROM Contact
                               WHERE FirstName IN : firstNames
                               AND LastName IN : lastNames
                               AND Phone IN:phones 
                               AND Email IN:emails
                               AND MailingPostalCode IN:mailingPostalCodes]; 
    
    for(Contact newContact : Trigger.new){
        for(Contact con:allContacts){
            if(con.FirstName == newContact.FirstName &&
               con.LastName == newContact.LastName &&
               con.Phone == newContact.Phone &&
               con.Email == newContact.Email &&
               con.MailingPostalCode == newContact.MailingPostalCode){
                   System.debug('con.FirstName == newContact.FirstName '+ con.FirstName +',' +newContact.FirstName);
                   System.debug('con.LastName == newContact.LastName '+ con.LastName +','+ newContact.LastName);
                   System.debug('con.Phone == newContact.Phone '+ con.Phone +','+ newContact.Phone);
                   System.debug('con.Email == newContact.Email' + con.Email +','+ newContact.Email);
                   System.debug('con.Email == newContact.Email ' + con.Email + ','+newContact.Email);
                   System.debug('con.MailingPostalCode == newContact.MailingPostalCode '+ con.MailingPostalCode + ','+ newContact.MailingPostalCode);
                   //System.debug('con.FirstName');
                   system.debug('The contact already Exist');
                   newContact.addError('The contact already Exist');
               }   
        }
    }
}