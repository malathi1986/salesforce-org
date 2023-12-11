public class Calculator {

    public Integer addNumbers(Integer a, Integer b){
        if(a > 0 || b > 0){
            return a+b;
        }else{
            return 0;
        }
    }
    
    public Integer subNumbers(Integer a, Integer b){
        if(a > 0 || b > 0){
            return a-b;
        }
        return 0;
    }
}