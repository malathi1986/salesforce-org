trigger LocalBasedCount on Contact (before insert,  before update, after insert) {

    if(Trigger.isInsert && Trigger.isAfter){
        EmployeeCallout.fetchEmployees(null);
    }
}