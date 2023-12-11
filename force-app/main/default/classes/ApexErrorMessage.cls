public class ApexErrorMessage {
    public String inputValue{get;set;}
    public void displayErrorMessage(){
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Invalid input');
        ApexPages.addMessage(myMsg);
        
    }
    
}