public class StringArrayTest {
    public static List<string> generateStringArray(integer n){
       List<string> myList=new List<string>();
        for(integer i=0;i<n;i++){
            myList.add('Test '+i);
            system.debug(myList[i]);       
        }
      return myList;      
    }
}