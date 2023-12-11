public class DuplicateString {
    public Map<String,Integer> duplString(List<String> stringList){
        Map<String,Integer> duplicatedString = new Map<String,Integer>();
        for(String str:stringList){
            integer count=0;
            for(string strcmp:stringList){
                if(str==strcmp){
                    count=count+1;
                }
               duplicatedString.put(str,count);
            }            
        }  
        System.debug('duplicatedString---->'+duplicatedString);
        System.debug('duplicatedString---->'+duplicatedString);
      return duplicatedString;  
    }  
    
}