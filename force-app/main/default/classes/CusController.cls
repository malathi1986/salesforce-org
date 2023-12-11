public class CusController {
    
    public Account acc{get;set;}
    
    public String accName{get;set;}
    
    public CusController(){
        acc=new Account();
    }
    
    public void save(){
        try{
            System.debug(LoggingLevel.INFO, 'Account Name--->'+accName);
            System.debug(LoggingLevel.INFO, 'Account Record--->'+acc);
            if(accName!=null && accName !=''){
                acc.Name = accName;
            }
            System.debug(LoggingLevel.INFO, 'Account Record 0--->'+acc);
            insert acc;
        }catch(DMLException e){
            
        }
    }
    public void cancel(){
        
    }
    
}