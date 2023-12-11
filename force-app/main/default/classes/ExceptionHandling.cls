public class ExceptionHandling {
    /*
*Handling specific exception
**/
    public static void queryAccounts(){
        try{
            Account acc = [select id , name from account where name ='TESt'];
        }
        catch(QueryException e){
            System.debug(LoggingLevel.ERROR, e.getMessage());
        }
    }
    
    /*
*Handling specific exception
**/
    public static void queryAccountsGeneric(){
        try{
            Account acc = [select id , name from account where name ='TESt'];
        }
        catch(Exception e){
            System.debug(LoggingLevel.ERROR, e.getMessage());
        }
    }
    /*
*Handling specific exception
**/
    public static void queryAccountsGenericAndSpecific(){
        try{
          Integer x =100/0;
          Account acc = [select id , name from account where name ='TESt'];
       }
        catch(MathException e){
           System.debug(LoggingLevel.ERROR, 'MathException --->'+e.getMessage());
        }
        catch(QueryException e){
            System.debug(LoggingLevel.ERROR, 'QueryException --->'+e.getMessage());
        }
        catch(Exception e){
            System.debug(LoggingLevel.ERROR, 'Exception---->'+e.getMessage());
        }
    }
    
    public static void queryAccountsThrowException(String str){
        try{
            if(str.contains('$'))
            throw new InvalidInputException('Input data is invalid','E-70000450');
        }
        catch(InvalidInputException e){
            System.debug(LoggingLevel.ERROR, 'Exception---->'+e.getErrorMessage());
        }
    }
    
}