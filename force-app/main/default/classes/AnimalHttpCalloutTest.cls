@isTest
public class AnimalHttpCalloutTest {
    
    @isTest
    public static void testinvokeAnimalWebservice_success(){
        Test.setMock(HttpCalloutMock.class, new AnimalsHttpCalloutMock());
        HttpResponse httpRes = AnimalTriggerWebserice.makeCallout();
        
        System.assert(httpRes.getBody().contains('majestic bear'));
        
    }
    
    @isTest
    public static void testinvokeAnimalWebservice_failure(){
        Test.setMock(HttpCalloutMock.class, new AnimalsHttpCalloutFailMock());
        HttpResponse httpRes = AnimalTriggerWebserice.makeCallout();
        
        System.assert(httpRes.getBody().contains('majestic bear'));
        
    }
}