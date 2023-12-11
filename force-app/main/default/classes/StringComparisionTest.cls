@isTest(SeeAllData = false)
public class StringComparisionTest {
    @isTest
    public static void insertString(){
        List<string> strList1 = new List<string>{'Chennai','Karnataka','Andhra'};
            List<string> strList2 = new List<string>{'Chennai','Karnataka','uttarpradesh'};
                List<string> expectedRes = new List<string>{'Andhra'}; 
                    StringComparision strcmp=new StringComparision();
        
        
        List<string> Strdiff = strcmp.strcmpr(strList1,strList2);
        
        System.assertEquals(expectedRes,Strdiff);
        
    }   
    @isTest
    public static void insertString2(){
        List<string> strList3 = new List<string>{'Chennai','Karnataka','Andhra'};
            List<string> strList4 = new List<string>{'Chennai','Karnataka','uttarpradesh'};
                List<string> expectedRes1 = new List<string>{'MadhyaPradesh'}; 
                    StringComparision strcmp=new StringComparision();
        
        
        List<string> Strdiff = strcmp.strcmpr(strList3,strList4);
        
        System.assertnotEquals(expectedRes1,Strdiff);
        
    }      
}