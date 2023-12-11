public class InvalidInputException extends Exception{
    
    public String errMessage='';
    public String errCode='';
    
    public InvalidInputException(String errM, String errC){
        errMessage=errM;
        errCode=errC;
    }
    
    public String getErrorMessage(){
        return 'error message ---> '+ errMessage + '  error code --->'+errCode;
    }
    
}