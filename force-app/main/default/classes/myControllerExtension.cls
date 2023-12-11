public class myControllerExtension {
    
    private final Account acct;
    public static boolean isEmpMandatory{set;get;}
    public static String ownership{set;get;}
    
    // The extension constructor initializes the private member
    // variable acct by using the getRecord method from the standard
    // controller.
    public myControllerExtension(ApexPages.StandardController stdController) {
        this.acct = (Account)stdController.getRecord();
        isEmpMandatory = false;
        System.debug('Test.....');
    }
    
    public String getGreeting() {
        return 'Hello ' + acct.name + ' (' + acct.id + ')';
    }
    
    public PageReference validateOwnership(){
        System.debug(LoggingLevel.DEBUG, 'validateOwnership--->'+ownership);
        if(ownership=='Public'){
            isEmpMandatory = true;
        }
        return null;
    }
}