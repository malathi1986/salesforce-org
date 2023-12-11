public with sharing class BatchCloseOpportunity implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext bc){
        String query = 'SELECT Id,Lastmodifieddate from Opportunity Where Amount < 1000 and StageName=\'Prospecting\'';
        System.debug(LoggingLevel.INFO, 'Query Result====>'+query );
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<SObject> oppList)
    {
        List<Opportunity> oppToProcess = (List<Opportunity>)oppList;
        List<Opportunity> updatedOppList = new  List<Opportunity>();
        for(Opportunity opp : oppToProcess){
            Opportunity newOpp=new Opportunity();
            newOpp.id=opp.Id;
            newOpp.StageName ='Closed-Lost';
            updatedOppList.add(newOpp);
        }
        update updatedOppList;
    }
    public void finish(Database.BatchableContext bc)
    {
    }
}