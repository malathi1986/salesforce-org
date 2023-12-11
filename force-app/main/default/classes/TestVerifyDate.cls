@isTest
public class TestVerifyDate {
	/*@TestSetup
	public static void makeData(){
		
	}*/
	@isTest
	public static void validate_CheckDates(){
		Date date1 = Date.newInstance(2023, 3, 20);
		Date date2 = Date.newInstance(2023, 3, 29);
		Date outcome = VerifyDate.CheckDates(date1,date2);
        Assert.areEqual(date2, outcome);

		
	}
	@isTest
	public static void validate_CheckDatesNotWithin30daysofDate1(){
		Date date1 = Date.newInstance(2023, 3, 20);
		Date date2 = Date.newInstance(2023, 4, 24);
		Date lastDay=Date.newInstance(date1.year(), date1.month(), 31);
		Date outcome = VerifyDate.CheckDates(date1,date2);
        Assert.areEqual(lastDay, outcome);

		
	}

	
	@isTest
	public static void validate_DateWithin30Days(){
		Date date1 = Date.newInstance(2023, 3, 20);
		Date date2 = Date.newInstance(2023, 2, 20);
	    Boolean outcome = VerifyDate.DateWithin30Days(date1,date2);
        Assert.areEqual(false, outcome);
	}
	@isTest
	public static void validate_Date2Within30DaysofDate1(){
		Date date1 = Date.newInstance(2023, 3, 20);
		//Date date30Days= Date.newInstance(2023,5,19);
		Date date2 = Date.newInstance(2023, 3, 29);
		//if (date2>=date30Days)
	    Boolean outcome = VerifyDate.DateWithin30Days(date1,date2);
        Assert.areEqual(false, outcome);
	}
	@isTest
	public static void validate_Date2NotWithin30DaysofDate1(){
		Date date1 = Date.newInstance(2023, 3, 20);
		//Date date30Days= Date.newInstance(2023,5,25);
		Date date2 = Date.newInstance(2023, 4, 24);
	    Boolean outcome = VerifyDate.DateWithin30Days(date1,date2);
        Assert.areEqual(true, outcome);
	}
	@isTest
	public static void validate_SetEndOfMonthDate(){
		Date date1 = Date.newInstance(2023, 3, 20);
		Date lastDay=Date.newInstance(date1.year(), date1.month(), 31);
		Date outcome=VerifyDate.SetEndOfMonthDate(date1);
		Assert.areEqual(lastDay, outcome);
	}
	
}