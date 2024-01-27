public with sharing class CollectionUtil {
    public static Integer[] sortNumbers(Integer[] numberList){
        Integer length = numberList.size();
        for (Integer i = 0; i < length-1; i++) {
           for (Integer j = i+1; j < length; j++) {
              if(numberList[i] > numberList[j]){
                Integer temp = numberList[i];
                numberList[i] = numberList[j];
                numberList[j] = temp;
              }
           }
        }
        System.debug('The Sorted list--->'+numberList);
        return numberList;
    }
}