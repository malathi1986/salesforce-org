public class AddPrimaryContact implements Queueable {
    
    Contact contactRecord;
    String stateAbr;
    public AddPrimaryContact(Contact contactRecord, String stateAbr){
        this.contactRecord  = contactRecord;
        this.stateAbr = stateAbr;
    }
    
    public void execute(QueueableContext context) {
        //contactRecord
        List<Contact> contactsToBeInserted = new List<Contact>();
        List<Account> accounts = [SELECT Id FROM Account WHERE BillingState =:this.stateAbr LIMIT 200];
        for(Account acc : accounts){
            Contact contactClone = (Contact)this.contactRecord.clone();
            contactClone.AccountId = acc.Id;
            contactsToBeInserted.add(contactClone);
        }
        insert contactsToBeInserted;    
        // Awesome processing logic here
        // Chain this job to next job by submitting the next job
        //System.enqueueJob(new SecondJob());
    }
}