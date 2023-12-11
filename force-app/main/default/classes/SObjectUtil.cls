public class SObjectUtil {
    
    public static boolean isRecordChanged(Map<Id,SObject> newMap,Map<Id,SObject> oldMap,List<String> fieldsList){
        
        for(Id recordId : newMap.keySet()){
            
            for(String fieldName : fieldsList){
                
                if(newMap.get(recordId).get(fieldName)!=oldMap.get(recordId).get(fieldName)){
                    return true;
                }
            }
        }
        return false;
    }

}