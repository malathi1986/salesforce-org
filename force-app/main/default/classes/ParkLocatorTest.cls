@isTest
public class ParkLocatorTest {
 
    @isTest static void ParkLocatorTestCallout() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        // Call the method that invokes a callout
        String[] expectedResult=ParkLocator.country('India');
        // Verify that a fake result is returned
        System.assertEquals('central Park', expectedResult[0]); 
    }
}