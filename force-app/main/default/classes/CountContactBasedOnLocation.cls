public class CountContactBasedOnLocation {
    
    public static  void countLocationBasedContacts(List<Contact> contacts){
        List<Account> accounts = [SELECT Id, New_York_Contact_Count__c FROM ACCOUNT where Id =:contacts[0].AccountId];
        System.debug('accounts---->'+accounts);
        Integer count = 0;
        for(Contact con : contacts){
            if(con.Department =='New York'){
                count ++;
            }
        }
        Decimal finalCount = count + accounts[0].New_York_Contact_Count__c == null ? 0 : accounts[0].New_York_Contact_Count__c ;
        accounts[0].New_York_Contact_Count__c = finalCount;
        
        update accounts;
        
    }

}