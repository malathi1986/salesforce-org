@isTest
public class NameValidatorTest {
    @isTest
    public static void validateName_null_returnedfalse(){
        Boolean returnedOutput = NameValidator.validateName(null);
        System.assertEquals(false, returnedOutput);
        Assert.areEqual(false, returnedOutput);
    } 
    @isTest
    public static void validateName_StringGreaterThan5_returnedTrue(){
        Boolean returnedOutput = NameValidator.validateName('malathi');
        System.assertEquals(true, returnedOutput);
        Assert.areEqual(true, returnedOutput);
    } 
    @isTest
    public static void validateName_StringLessThan5_returnedFalse(){
        Boolean returnedOutput = NameValidator.validateName('mala');
        System.assertEquals(false, returnedOutput);
        Assert.areEqual(false, returnedOutput);
    }
}