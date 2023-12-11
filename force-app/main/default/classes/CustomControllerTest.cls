@isTest
public class CustomControllerTest {

    @isTest
    public static void testConstructor(){
        
        Account a = new Account(); // A test account is created with the required field values   
        a.Name = 'Test';      
        insert a;
        
        a.Rating = 'Hot';       
        a.Type = 'Customer';       
        a.Industry = 'Healthcare'; 
        Test.setMock(HttpCalloutMock.class, new AnimalsHttpCalloutFailMock());
        PageReference testPage = Page.AccPage; // A page reference for the Visualforce page is created      
        Test.setCurrentPage(testPage); // A method is used to set the current page reference      
        ApexPages.currentPage().getParameters().put('id', a.Id); // Query parameters can be set and used in the 
        CustomController cc = new CustomController(); // The custom controller is instantiated       
        PageReference pageRef = cc.save(); // The methods in the custom controller are called
        Account b = cc.getAccount();
        System.assertEquals(true, b!=null);
    }
}