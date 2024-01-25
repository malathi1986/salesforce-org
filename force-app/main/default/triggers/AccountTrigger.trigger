trigger AccountTrigger on Account (before insert,before update) {
    if(trigger.isBefore &&(trigger.isInsert || trigger.isUpdate)){
        AccountTriggerHandler.isBeforeTrigger(trigger.new );
    }

}