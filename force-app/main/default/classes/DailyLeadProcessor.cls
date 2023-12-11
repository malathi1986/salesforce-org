public class DailyLeadProcessor implements Schedulable {
    public void execute(SchedulableContext ctx) {
        List<Lead> leadslist = [SELECT Id,Leadsource
                                FROM Lead
                                WHERE Leadsource=null];
        if(!leadslist.isEmpty()){
            for(lead l:leadslist){
                l.Leadsource='Dreamforce';
            }
            update leadslist; 
        }
    }
    
}