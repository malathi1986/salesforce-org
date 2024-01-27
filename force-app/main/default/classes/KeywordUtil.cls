public with sharing class KeywordUtil {
    public KeywordUtil() {

    }
    public static final String ACCOUNT_CHECKING = 'Checking';
    
    public String ACCOUNT_SAVINGS = 'Checking';

    @SuppressWarnings
    public static void validateAccount(){
        String ext;
        System.debug(LoggingLevel.DEBUG, ACCOUNT_CHECKING);
        //ACCOUNT_CHECKING = 'Checking plus';
        Account scc = [select id from account limit 1];
    }

    public void procesAccount(){
        validateAccount();
    }

    

    /*KeywordUtil key = new KeywordUtil();
    key.procesAccount();*/
}