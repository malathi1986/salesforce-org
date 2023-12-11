public class OppCustomCtrl {
    public opportunity opp{set;get;}
    public string CloseDate{set;get;}
    public OppCustomCtrl(){
        opp=new opportunity();
    }
    
    public Pagereference saveRecord(){
        if(!validateFormData())
        { 
            System.debug('Inside level---->');
         return null;
        }
       try{
            insert opp;  
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Opportunity sucessfully saved...'));
        }catch(DMLException e){
            System.debug(LoggingLevel.ERROR, 'Error occured'+e.getMessage());    
        }
        return null;
        
    }
    private boolean validateFormData(){
        
        if(opp!=null && opp.name!=''&&string.valueOf(opp.name).length()>10) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter opportubnityName less than 10 characters'));
            return false;
        } 
        return true;
    }
    public void cancel(){
        
    }
    
}