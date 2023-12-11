public class LeadScoreUtil {
    /*    List<Leads> newLeads=new List<newLeads>();
for(lead l:newLeads)
{*/
    
    public static void calculateLeadscore(List<Lead> leadsList){
        
        for(Lead l : leadsList){
            
            if((l.Email!=null && l.Company!=null&& l.MobilePhone!=null)){
                l.LeadScore__c='100';            
            }else if((l.Email==null&& l.MobilePhone==null)){            
                l.LeadScore__c='80';                      
            }else if(l.MobilePhone==null){
                l.LeadScore__c='50';
            }else{l.LeadScore__c='Not a Valid lead';}
        }
        
    } 
    
}