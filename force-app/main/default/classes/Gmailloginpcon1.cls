/*public class LoginPages {

public String password { get; set; }
public String username { get; set; }

public PageReference loginUser() {
PageReference newPage = new PageReference('/apex/welcomePage_vf?core.apexpages.request.devconsole=1');
newPage.setRedirect(true);
return newPage;
} 

}*/
public class Gmailloginpcon1
{
    
    public String password{ get; set; }
    public String username{ get; set; }
    
        public String getWelcomeMessage(){ return 'Welcome back!!!';}
    
    
    public gmailuser__c reg { set; get;}
    public transient String errorMessage { get; set; }
    
    
    public List<gmailuser__c> gmailuserlist;
    
    public gmailloginpcon1(ApexPages.StandardController controller)
    {
        reg =(gmailuser__c)controller.getRecord();
    }
    public PageReference Verifyuser()
    {
        try
        {
            List<gmailuser__c> yp = new List<gmailuser__c>(); 

            if(!String.isBlank(username))
            {
                yp = [SELECT username__c,password__c FROM gmailuser__c WHERE username__c =:username LIMIT 1];  
                System.debug(LoggingLevel.INFO, 'yp--->'+yp);
                if(yp.size()>0)
                {
                    
                    if(username == yp[0].username__c && password == yp[0].password__c)
                    {
                        PageReference newPage = new PageReference('/apex/welcomePage_vf?core.apexpages.request.devconsole=1');
                        newPage.setRedirect(true);
                        return newpage;
                    }
                    
                }
                else
                {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Invalid username and password please check'));
                }
            }
            else
            {
                
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please enter username and password'));
            }
        }
        catch(Exception e)
        {
        }
        
        return null;     
    }
    
}