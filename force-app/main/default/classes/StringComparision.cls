public class StringComparision {
    
    public list<string> strcmpr(List<String> stringList1,List<String> stringList2)
    { 
        List<string> resultList = new List<string>();
        for(string strdiff1:stringList1){
            boolean isMatchFound = false;
            for(string strdiff2:stringList2){
                
                if(strdiff1==strdiff2)
                {
                    isMatchFound = true;
                }
                
            }
            if(isMatchFound==false){
                resultList.add(strdiff1);
            }
        }
        return resultList;														
    }
    
}