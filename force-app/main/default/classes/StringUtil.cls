public with sharing class StringUtil {
    
    //Reverse a string in apex
    public static String getStringReverse(String str){
       // Integer length = str.length();
        String strRev='';
        String[] strArr = str.split('');
        System.debug(LoggingLevel.INFO, 'strArr ---'+strArr);
        for (Integer i = strArr.size()-1; i >= 0; i--) {
            System.debug('The Index value is:'+i);
            System.debug('The Reverses String is:'+strArr[i]);
            strRev=strRev+strArr[i];     
        }
        System.debug('The Reverses String is:'+strRev);
        return strRev;
    }

    // In a given string, find the middle character
    public static String getMiddleChar(String str){
        String[] strArr = str.split('');
        String middleChar='';
        Integer arrayMidPoint=strArr.size()/2;
        //1,2,3,4,5
        System.debug(LoggingLevel.INFO, 'Mid point strArr '+strArr[arrayMidPoint]);
        System.debug(LoggingLevel.INFO, 'strArr ---'+strArr);
        for (Integer i = 0; i < arrayMidPoint;i++) {
             middleChar=strArr[i];   
        }
        for (Integer i = 0; i < strArr.size() -1;i++) {
            if(i == (strArr.size() / 2)){
                middleChar=strArr[i];
                break;
            }           
        }
        
       // Integer arrayMidPoint=strArr.size()/(3/4);

        System.debug('The Middle String is:'+middleChar);
        return middleChar;
    }

    /**
     * 
     *  1
     *  1 2
     *  1 2 3
     *  1 2 3 4
     *  1 2 3 4 5  
     */
    public static Integer printGivenNumbers(Integer num){
      //Integer[] intArrLength
        for(Integer i=num;i<=num;i++){
            //System.debug('The printed format is :'+i);
            String printVal ='';
            for(Integer j=1;j<=i;j++){
                printVal = printVal + j;
            }   
            System.debug('The printed format is :'+printVal);  
        } 
        return num; 
    }

    // Find out if the reverse of a given number is same as the orignal number

    public static Boolean isReverseSame(Integer num){
        //Integer[] intArrLength
        String[] sNum=String.valueOf(num).split('');
        String numRev='';
        Integer[] intArr;
        //System.debug(LoggingLevel.INFO, 'strArr ---'+strArr);
        for (Integer i = sNum.size()-1; i >= 0; i--) {
            System.debug('The Index value is:'+i);
            System.debug('The Reverse format of the Number is:'+sNum[i]);
            numRev=numRev+sNum[i];     
        }
        
        if(Integer.valueOf(numRev)==num){
            System.debug('The Reverse Number is:'+numRev);
            return true;


        }
        return false;
      }

      ////Write a method to find a character which got the highest occurance in a string
     // For example. If "India" is passed as an input, the output should be i = 2
      public static Integer findNumberOfOccurances(String str){
        //Integer[] intArrLength
        String[] strArr = str.split(''); 
        Integer charCount;
        Map<String, Integer> charCounts = new Map<String, Integer>(); 
        for(Integer i=0;i<strArr.size();i++){
            if(charCounts.get(strArr[i]) == null){
                charCounts.put(strArr[i], 1);

            } else {
                charCount =charCounts.get(strArr[i]);
                charCounts.put(strArr[i], charCount+1);
            }
        }

        Integer temp = 0;
        String maxCountChar = null;
        // A = 3, X = 7, s = 5
        for(String s:charCounts.keySet()){
           Integer charCountVal= charCounts.get(s);
           if(charCountVal > temp){
             temp = charCount;
             maxCountChar = s;
           }
        }
        System.debug(LoggingLevel.INFO, 'maxCountChar '+maxCountChar);
        return charCount;
    }
    
    //Find the smallest number in an array. For example, when we pass [1,2,4,5,8,2,1] the method should return 1
     public static Integer toFindSmallestNumber(Integer[] arrayToFind){
        Integer temp=0;
        
        for(Integer i=0;i<arrayToFind.size();i++){
            /*if(i==0){
                temp=arrayToFind[i]; 
            }*/
            if(temp>arrayToFind[i]){
                temp=arrayToFind[i];
            }    
        }
        System.debug(LoggingLevel.INFO, 'smallestNum '+temp);
        return temp;
     }
}