public with sharing class LeadConversion implements Database.Batchable<SObject>{

    public Database.QueryLocator start(Database.BatchableContext ctx){
        return Database.getQueryLocator([SELECT Id FROM Lead WHERE IsConverted = FALSE]);
    }
    private final String CONVERTED_STATUS = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1].MasterLabel;
    public void execute(Database.BatchableContext ctx, List<Lead> leadRecords){
        List<database.LeadConvert> listofLeadsToConvert=new List<database.LeadConvert>();
        for(Lead lead:leadRecords){
            Database.LeadConvert lc=new Database.LeadConvert();
            lc.setLeadId(lead.Id);
            lc.setConvertedStatus(CONVERTED_STATUS);
            listofLeadsToConvert.add(lc);
        }
        database.convertLead(listofLeadsToConvert,true);
    }
        public void finish(Database.BatchableContext ctx){

        }

    }