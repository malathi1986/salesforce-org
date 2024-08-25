public with sharing class AutoLeadConversionTriggerHandler {
    public AutoLeadConversionTriggerHandler() {

    }
    
    public static void convertLeads(List<lead> leadRecords) {
   /* Set<ID> leadIds= new Set<ID>();
    for(lead leadRecord : leadList) {
        if (leadRecord.Status == 'Qualified' && leadRecord.isConverted == false){
              
             leadIds.add(leadRecord.Id);
        }*/
        LeadStatus CLeadStatus= [SELECT Id, MasterLabel FROM LeadStatus WHERE  IsConverted=true Limit 1];
        List<database.LeadConvert> listofLeadsToConvert=new List<database.LeadConvert>();
        for(Lead lead:leadRecords){
            if (lead.Status == 'Qualified' && lead.isConverted == false){
            Database.LeadConvert lc=new Database.LeadConvert();
            lc.setLeadId(lead.Id);
            lc.setConvertedStatus(CLeadStatus.MasterLabel);
            listofLeadsToConvert.add(lc);
        }
      database.convertLead(listofLeadsToConvert,true);

}
 }
}