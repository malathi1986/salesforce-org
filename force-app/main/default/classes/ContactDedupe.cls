global class ContactDedupe implements Database.Batchable<sObject> {
    ///* Query all the contact Records*/
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id,'
                                        +'(SELECT Id,LastName,Email,RecordType.Name FROM Contacts) FROM Account WHERE Id =\'0016R00003KSyDIQA1\'');
        
    }
    
    public void execute(Database.BatchableContext bc, List<Account> scope){
        // process each batch of records
        List<contact> contacts = new List<contact>();
        List<Contact> winningRecords = new List<Contact>();
        List<Contact> duplicateContactsToDelete = new List<Contact>();
        for (Account acc : scope) {
            contacts = acc.Contacts;
            Contact winningRecord=getWinningRecord(contacts);
            List<Contact> duplicateContactRecords = null;
            if(contacts.size()>0){
              duplicateContactRecords=getDuplicateRecords(contacts, winningRecord);   
              System.debug(LoggingLevel.INFO, 'duplicateContactRecords '+duplicateContactRecords);            
            }
            //MERGE
            winningRecord = mergeContactRecordFields(duplicateContactRecords, winningRecord);
            
            
                winningRecords.add(winningRecord);

                duplicateContactsToDelete.addAll(duplicateContactRecords);    
            
            
            System.debug('winningRecord: ' +winningRecord);   
        }  
        executeDedupe(winningRecords, duplicateContactsToDelete);
       
    }

    public void executeDedupe(List<Contact> winningRecords, List<Contact> duplicateContactsToDelete){
        Savepoint sp = Database.setSavepoint();
        try {
            sp = Database.setSavepoint();
            update winningRecords;
            delete duplicateContactsToDelete;    
        } catch (Exception e) {
            Database.rollback(sp);
        }
    }
    public Contact mergeContactRecordFields(List<Contact> duplicateContacts, Contact winningRecord){
       List<String> customSettingsValues= getValuesFromCustomSettings();
        for (Contact duplicateContactRecord : duplicateContacts) {
            for(String fieldName :customSettingsValues){
                winningRecord.put(fieldName,duplicateContactRecord.get(fieldName));
            }
        }
        return winningRecord;
    }
    public List<Contact> getDuplicateRecords(List<Contact> Contacts, Contact winningRecord){
        List<Contact> duplicateContacts = new List<Contact>();
        Datacloud.FindDuplicatesResult[] results = Datacloud.FindDuplicates.findDuplicates(contacts);
            for (Datacloud.FindDuplicatesResult findDupeResult : results) {
                for (Datacloud.DuplicateResult dupeResult : findDupeResult.getDuplicateResults()) {
                    for (Datacloud.MatchResult matchResult : dupeResult.getMatchResults()) {
                        for (Datacloud.MatchRecord matchRecord : matchResult.getMatchRecords()) {
                            if ((matchRecord.getRecord().get('Id') != winningRecord.Id)) {
                                duplicateContacts.add((Contact)matchRecord.getRecord());
                                System.debug('Duplicate Record: ' + matchRecord.getRecord());
                            }
                        }
                    }
                }
            }
            return duplicateContacts;
    }
    public void finish(Database.BatchableContext bc){
        
    }
    public List<String> getValuesFromCustomSettings(){
        Dedupe_Settings__c dedupeSettings = Dedupe_Settings__c.getValues(UserInfo.getProfileId());
        return dedupeSettings.Value__c.split(',');
    }
    
    public Contact getWinningRecord(List<Contact> contacts){
        for(Contact con:contacts){
            if(con.RecordType.Name=='Primary'){
                System.debug('RecordType:=====> ' + con);
                return con;
                
            }
        }
        return null;
    }
}