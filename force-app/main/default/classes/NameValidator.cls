public class NameValidator {
    
    public static Boolean validateName(String name){
        if(name == null){
            return false;
        }
        if(name.length() >= 5){
            return true;
        }else {
            return false;
        }
    }  
}