public class AccountHandler {
    
    public static Account insertNewAccount(String accountName){
        try{
            Account acc = new Account(Name = accountName);
            insert acc;
            return acc;
        }catch(Exception e){
            return null;
        }
    }

}