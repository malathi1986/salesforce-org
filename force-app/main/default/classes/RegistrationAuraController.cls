global class RegistrationAuraController {
    
    @AuraEnabled
    public static Boolean verifyRegistrationDetails(String fstName, String MiddleName,String lstName,String Email,String Phone,String Address){
        System.debug(LoggingLevel.INFO,'lstName--->'+lstName);
                System.debug(LoggingLevel.INFO,'Email--->'+Email);
        Contact con = new Contact(FirstName =fstName,lastname=lstName, email = Email,Phone = Phone,MailingCity =Address);
        try{
            INSERT con;                                                      
        }
        catch(Exception e){
            System.debug(LoggingLevel.INFO,'TEST'+e.getMessage());
            return false;
        }
        return true;
    }    
}