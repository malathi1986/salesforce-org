global class LoginAuraController {
    
    @AuraEnabled
    public static Boolean verifyLoginCredentials(String username, String password){
        return true;
    }
}