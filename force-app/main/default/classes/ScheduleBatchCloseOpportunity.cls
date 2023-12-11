global with sharing class ScheduleBatchCloseOpportunity implements Schedulable {
    global void execute(SchedulableContext sc) {
        BatchCloseOpportunity b = new BatchCloseOpportunity(); 
        Database.executeBatch(b);
     }
}