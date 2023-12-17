trigger OpportunityTrigger on Opportunity (after insert, after update) {
    if(Trigger.isAfter &&  (Trigger.isInsert || Trigger.isUpdate)){
        OpportunityTriggerHandler.afterCreateorUpdate(Trigger.new, Trigger.old);
     }
}