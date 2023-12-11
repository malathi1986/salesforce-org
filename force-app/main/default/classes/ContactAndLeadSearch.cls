public class ContactAndLeadSearch {
    public static List <List<SObject>> searchContactsAndLeads(String Smith){
        List <List<SObject>> searchlist=[FIND 'Smith' IN ALL FIELDS RETURNING Contact(LastName),Lead(LastName)];
        return searchlist;
    }
}