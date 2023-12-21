@isTest
public with sharing class OutboundIntegratorTest {

    @TestSetup
    static void makeData(){
        Opportunity opp = new Opportunity();
        //{"records" :[{"attributes" : {"type" : "Opportunity", "referenceId" : "100000"},"Name" : "testIntegeratiorr","CloseDate" : "2023-12-20","StageName" : "Closed Won"}]}
        opp.Name = 'OutboundIntegratorTest_'+System.now();
        opp.CloseDate = System.today() + 30;
        opp.StageName = 'Closed Won';
        insert opp;
    }
    @isTest
    public static void invokeApi_ValidJson_Successful(){
        Test.setMock(HttpCalloutMock.class, new OutboundIntegratorHttpMock());
        Test.startTest();
        Opportunity oppr = [SELECT Id FROM Opportunity WHERE NAME LIKE 'OutboundIntegratorTest_%' LIMIT 1];
        String outAPIString = '{"vehicleTypes":null,"vehicleName":null,"recordIds":["'+oppr.Id+'"],"makeId":null,"integrationName":"Partner_Opportunity_Integration"}';
        try{
            OutboundIntegrator.invokeApi(outAPIString);
        } catch(Exception e ){
            e.getCause();
        }
        Test.stopTest();
    }
}