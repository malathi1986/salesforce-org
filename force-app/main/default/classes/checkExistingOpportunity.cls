public with sharing class checkExistingOpportunity {

    public static string checkExistingOpportunity(){
        return '';
    }
   
    @AuraEnabled(cacheable=true) 
    public static string checkOpportunity(String opportunityName) {
    
            List<Opportunity> opportunityNameExists = [SELECT Id FROM Opportunity WHERE Name =:opportunityName LIMIT 1];
            if(opportunityNameExists!=null & opportunityNameExists.size() > 0){
                
                return 'Opportunity name already exists';
            } else {
                return 'New opportunity is created';
            }
            
            

    }
}