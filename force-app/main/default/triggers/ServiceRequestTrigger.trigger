trigger ServiceRequestTrigger on Service_Request__c (after insert) {
   if(Trigger.isAfter &&  (Trigger.isInsert || Trigger.isUpdate)){
       ServiceRequestTriggerHandler.afterCreateorUpdate(Trigger.new, Trigger.old);
    }
}