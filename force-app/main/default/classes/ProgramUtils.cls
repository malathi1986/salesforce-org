public with sharing class ProgramUtils {
    public ProgramUtils() {

    }

    public static void continueStatement(){
        Integer length = 20;
     
        for (Integer j = 0; j < length; j++) {
            System.debug('************************');
            System.debug('Index '+j);
            if(Math.mod(j, 2) == 0){
                continue;
            }
            //
            System.debug('Index j proessing starts '+ j);
            System.debug('Index j proessing ends '+ j);
            System.debug('************************');
        }
        
    }

    public static void breakStatement(){
        Integer length = 20;
     
        for (Integer j = 0; j < length; j++) {
            System.debug('************************');
            System.debug('Index '+j);
            if(Math.mod(j, 2) == 0){
                break;
            }
            //
            System.debug('Index j proessing starts '+ j);
            System.debug('Index j proessing ends '+ j);
            System.debug('************************');
        }
    }

    public static void switchCaseStatement(Integer caseValue){
        
        switch on caseValue {
            when 1 {
                System.debug('Case 1 executed...');
            }
            when 2 {
                System.debug('Case 2 executed...');
            }
            when 3 {
                System.debug('Case 3 executed...');
            }
            when else {
                System.debug('Else executed...');
            }
        }
    }

    public static void whileLoopStatement() {
        Integer index = 0;
        while(index<100){
            //System.debug('Index '+index);
            index++;
        }

        Integer index1 = 0;
        while(true){
            System.debug('while Index '+index1);
            index1++;
            if((index1/2) == 25){
                break;
            }
        }
    }
}