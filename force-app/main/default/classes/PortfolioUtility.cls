public with sharing class PortfolioUtility {
    PortfolioUtility() {
    }
    @AuraEnabled(cacheable=true) 
    public static List<Account>  getAccountsByCountry(List<String> countryName) {
        System.debug(LoggingLevel.INFO, 'Method invoked with argument '+countryName);
        return [SELECT Id,Name,BillingCountry FROM Account WHERE BillingCountry IN :countryName];  
    }
    @AuraEnabled(cacheable=true) 
    public static Map<String,Account>  getRelatedListForSelectedAcct(List<String> relatedList,List<String> acctIds) {
        Map<String,Account> relatedObj =new Map<String,Account>();
        for(string objName:relatedList){
            Account acct;
            if(objName=='Contacts'){
                 acct= [SELECT Id, Name,BillingCountry ,(SELECT Id, Name FROM Contacts) FROM Account WHERE Id IN :acctIds];
            }
            if(objName=='Opportunities'){
                acct=[SELECT Id, Name,BillingCountry ,(SELECT Id, Name FROM Opportunities) FROM Account WHERE Id IN :acctIds];
            }
            relatedObj.put(objName,acct);

        }
       return relatedObj;
    }
}