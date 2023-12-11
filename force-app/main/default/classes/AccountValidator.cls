public class AccountValidator {
    
    public static String validateAccount(List<Account> accounts) {
        String accountStatus = 'invalid';
        for(Account acc : accounts){
            if(acc.AnnualRevenue !=null && acc.NumberOfEmployees > 4){
                accountStatus = 'valid';
            } else {
                accountStatus = 'invalid';
            }          
        }
        return accountStatus;      
    }
}