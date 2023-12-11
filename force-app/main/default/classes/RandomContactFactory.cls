public class RandomContactFactory {
    public static List<Contact> generateRandomContacts (Integer numContacts,String lastName){
        
        List<Contact> contacts = new List<contact>();   
        for (Integer i = 0; i < numContacts; i++) {
            Contact con = new Contact();
            con.FirstName = 'Test ' + i; 
            con.lastName = lastName;
            
            //Contact con1 = new Contact(FirstName = 'Test ' + i, LastName = lastName  );
            
            contacts.add(con);
        }
        return Contacts;
    }
    
}