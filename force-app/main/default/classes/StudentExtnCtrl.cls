public class StudentExtnCtrl {
    private final Student__c stud;
    
     public StudentExtnCtrl(ApexPages.StandardController stdController) {
        this.stud = (Student__c)stdController.getRecord();
    }

}