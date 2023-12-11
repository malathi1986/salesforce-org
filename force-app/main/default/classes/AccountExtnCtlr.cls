public class AccountExtnCtlr {
    
    
    private final Account acct;
    
    // The extension constructor initializes the private member
    // variable acct by using the getRecord method from the standard
    // controller.
    public AccountExtnCtlr(ApexPages.StandardController stdController) {
        this.acct = (Account)stdController.getRecord();
    }
    
    public void validateAndSave(){
        System.debug(LoggingLevel.DEBUG, 'Reached If q----->'+acct.Active__c);
        if(acct.Active__c==''){
            System.debug(LoggingLevel.INFO, 'Reached If----->');
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select whether it is active account or not'));
        }else{
            System.debug(LoggingLevel.INFO, 'Reached Else----->');
            //super.save();
        }
    }
    
    
    	
}