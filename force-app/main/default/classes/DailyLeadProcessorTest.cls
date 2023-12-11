@isTest
public class DailyLeadProcessorTest {
    @testSetup
    public static void Leadtestmethod(){
        
        List<Lead> leads = new List<Lead>();
        for(integer i=0;i<200;i++){
            Lead l = new Lead(LastName ='Test002'+i, Company ='Test', Leadsource= null);
            leads.add(l);
            
        }
        insert leads;
  
    }
    @isTest
    public static void testScheduledJob(){
        Test.startTest();
        //DailyLeadProcessor ScheduledApexTest = new DailyLeadProcessor ();
        String sch = '20 30 8 10 2 ?';
        String jobId = System.schedule('ScheduledApexTest',
                                       sch,
                                       new DailyLeadProcessor());
        Test.stopTest();
       
        List<Lead> results = [SELECT Id FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, results.size());
        
        
    }  
}