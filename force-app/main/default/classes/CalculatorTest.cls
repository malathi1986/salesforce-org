@isTest(seeAllData =  false)
public class CalculatorTest {
    
    public static integer a;
    public static integer b;
    @TestSetup
    public static void setupTestData(){
        a=10;
        b=100;
    }
    
    @isTest
    public static void addNumbers_Positive(){
        
        Calculator calc = new Calculator();
        Integer output = calc.addNumbers(2,3);
        System.assertEquals(5,output);
        System.assert(output==5);
    }
    @isTest
    public static void addNumbers_Negative(){
        
        Calculator calc = new Calculator();
        Integer output = calc.addNumbers(-20,3);
        System.assertEquals(-17,output);
    }
    @isTest
    public static void addNumbers_Negative1(){
        
        Calculator calc = new Calculator();
        Integer output = calc.addNumbers(-20,-3);
        System.assertEquals(0,output);
    }
    @isTest
    public static void subNumbers_Positive(){
        
        Calculator calc = new Calculator();
        Integer output = calc.subNumbers(20,5);
        System.assertEquals(15,output);
    } 
    @isTest
    public static void subNumbers_Negative(){
        Calculator calc = new Calculator();
        Integer output = calc.subNumbers(20,-5);
        System.assertEquals(25,output);
        
    } 
    @isTest
    public static void subNumbers_Negative1(){
        
        Test.startTest();
        Calculator calc = new Calculator();
        Integer output = calc.subNumbers(-20,-5);
        System.assertEquals(0,output);
        Test.stopTest();
        
    }
    
    public testmethod static void subNumbers_Negative2(){
        Calculator calc = new Calculator();
        Integer output = calc.subNumbers(-20,-5);
        System.assertEquals(0,output);
        
    }
}