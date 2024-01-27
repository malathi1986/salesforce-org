public with sharing class RecordUtils {
    public RecordUtils() {

    }

    public static Boolean isSameRecord(List<String> fields, SObject record, SObject recordToCompare){
        Boolean isSame = true;
        for(String dynamicField:fields){
            if(record.get(dynamicField)!=recordToCompare.get(dynamicField)){
                isSame = false;
                break;
            } 
        }
        System.debug('Boolean Value is--->'+isSame);
        return isSame;
    }

    public static Boolean isValueExist(List<String> masterList, List<String> valuesToFind, Boolean strictMatch){
        //{'Apple', 'Orange', 'Lemon', 'Melon'}
        //{'Lemon','Berries', 'Banana', 'Melon'}
        Boolean matchFound=false;
        
        for(String stringToFind:valuesToFind){
            Boolean innerMatch = false;
            for(String main:masterList){
                if(main==stringToFind){ 
                    innerMatch = true;
                }
            } 
            if(innerMatch == false){
                matchFound = false;
            } else if(matchFound == true && innerMatch == true) {
                matchFound = true;
            }  
        }
       return matchFound;
    }

    public static Boolean isValueExist2(List<String> masterList, List<String> valuesToFind, Boolean strictMatch){
        //{'Apple', 'Orange', 'Lemon', 'Melon'}
        //{'Berries','Lemon'}
        Boolean matchFound=false;
        for(String stringToFind:valuesToFind){
            Boolean innerMatch = false;
            for(String main:masterList){
                if(main==stringToFind){ 
                    innerMatch = true;
                }
            }
            //If it is stict match and if one of the value is not found then break the loop
            if(strictMatch && innerMatch == false){
                matchFound = false;
                break;
            } 
            // If it is not a strict match then continue to check for additional values
            if(!strictMatch && innerMatch){
                matchFound = true;
            }
        }
        ///
       return matchFound;
    }

    public static Boolean isValueExist3(List<String> masterList, List<String> valuesToFind){
        //{'Apple', 'Orange', 'Lemon', 'Melon'}
        //{'Berries','Lemon'}
        Boolean matchFound=false;
        Map<String, Boolean> comparisionMap = new Map<String, Boolean>();
        for(String stringToFind:valuesToFind){
            Boolean innerMatch = false;
            for(String main:masterList){
                if(main==stringToFind){ 
                    innerMatch = true;
                }
            }
            comparisionMap.put(stringToFind, innerMatch);
        }
        System.debug('The matched value is--->'+matchFound);
       return matchFound;
    }


    public static Boolean compareContactRecordUsingEmailLastname(String email, String lastName, Contact record, Contact recordToCompare){
        Boolean isSame = false;
        if(record.Email == recordToCompare.Email ){
            isSame = true;
        }else {
            isSame = false;
        }
        if(record.lastName == recordToCompare.lastName ){
            isSame = true;
        }else {
            isSame = false;
        }
        return isSame;
    }
}