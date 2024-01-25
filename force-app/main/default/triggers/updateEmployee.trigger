trigger updateEmployee on Account (after insert, after update) {
    
    List<Id> accountIds = new List<Id>();
    for(Account acc : Trigger.new){
        accountIds.add(acc.Id);
    }    
    if(Trigger.isAfter && Trigger.isInsert){
        //EmployeeCallout.fetchEmployees(accountIds);
    }
     
}