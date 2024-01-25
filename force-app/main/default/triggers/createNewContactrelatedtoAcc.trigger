trigger createNewContactrelatedtoAcc on Account (after insert,after update) {
    List<Contact> contacts=new List<Contact>();
    for(Account acc:trigger.new)
    {
      Contact con=new Contact(AccountId=acc.id+'Acc',Lastname=acc.Name) ; 
    }
}