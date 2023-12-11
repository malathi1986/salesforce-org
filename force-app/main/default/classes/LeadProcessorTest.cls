@isTest
public class LeadProcessorTest {

    @testSetup
    public static void createTestData(){
        List<Lead> leads = new List<Lead>();
        for(Integer i=0;i<200;i++){
            Lead l = new Lead(LastName ='Test002'+i, Company ='Test');
            leads.add(l);
        }
        insert leads;
    }
    @isTest
    public static void testBatch(){
        Test.startTest();
        LeadProcessor myBatchObject = new LeadProcessor ();
		Id batchId = Database.executeBatch(myBatchObject);
        Test.stopTest();
        List<Lead> updatedLeads = [SELECT Id,LeadSource FROM Lead WHERE LastName LIKE 'Test002%'];
        for(Lead l : updatedLeads){
            System.assertEquals(true, l.LeadSource =='Dreamforce');
        }
    }
}