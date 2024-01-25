trigger AnimalTrigger on Animal__c (after insert) {
  AnimalTriggerWebserice.invokeAnimalWebservice();
}