@isTest
public with sharing class MathCalculatorTest {
    public MathCalculatorTest() {

    }

    @isTest
    public static void add_towValidIntegers_validInteger(){
        Integer result = MathCalculator.add(3,4);
        System.assertEquals(7, result);
    }

    @isTest
    public static void add_towValidIntegers_ConstructorInvoked(){
        MathCalculator mat = new MathCalculator();
        System.assert(true);
    }
}