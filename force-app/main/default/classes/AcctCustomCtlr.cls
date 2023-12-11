public class AcctCustomCtlr {
    
    public Account acct{set;get;}
    public Boolean isEmpMandatory{set;get;}
    
    public AcctCustomCtlr(){
        acct = new Account();
        isEmpMandatory=false;
    }
    
    public PageReference saveRecord(){
        if(!validateFormData()){
            System.debug('Inside level---->');
            return null;
        }
        
        try{
            insert acct;  
           // ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Account sucessfully saved...'));
             PageReference acctPage = new ApexPages.StandardController(acct).view();
	        acctPage.setRedirect(true);
	        return acctPage;
        }catch(DMLException e){
            System.debug(LoggingLevel.ERROR, 'Error occured'+e.getMessage());    
        }
        
        return null;
    }
    
    private Boolean validateFormData(){
        if(acct!=null && acct.Name!='' && String.valueof(acct.Name).length() > 10){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter account less than 10 characters'));
            return false;
        }
        return true;
    }
    
    public void validateOwnership(){
        System.debug(LoggingLevel.DEBUG, 'validateOwnership--->'+acct.ownership);
        if(acct.ownership=='Public'){
            isEmpMandatory = true;
        }
        //return null;
    }
    
}