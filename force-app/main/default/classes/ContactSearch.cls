public class ContactSearch {

    public static List<contact> searchForContacts(string s1,string s2){
        List<contact> con= [SELECT Id,Name FROM contact where LastName=:s1 AND MailingPostalCode=:s2];
        system.debug('List of contacts returned--->'+con); 
        return con;
             
    }
   
}