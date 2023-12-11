public with sharing class ApexControllerSample {
    @AuraEnabled
    public static List<String> getCountries(){
        List<String> countries = new List<String>();
        countries.add('USA');
        countries.add('India');
        return countries;
    }
}