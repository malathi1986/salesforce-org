@RestResource(urlMapping='/api/*')
global with sharing class AccContactRestAPIClass {
   @HttpPost
    global static void doPost(){
        String jsonString=RestContext.request.requestbody.toString();
        System.debug('Request body===>'+jsonString) ;
        AccountData acctData = (AccountData) JSON.deserialize(jsonString, AccountData.class);
         Account a=new Account();
         a.Name=acctData.account_name;
         a.AnnualRevenue=Decimal.valueOf(acctData.account_revenue);
         ContactData conData = acctData.contact_record;
         Contact con=new Contact();
         con.LastName=conData.lastname;
         con.Phone=conData.phone;
         con.Email=conData.email;
         Boolean isSuccess = true;
         try {
            insert a;
            //Master detail established here
            con.AccountId = a.Id;
            insert con;
         } catch (Exception e) {
            isSuccess = false;
            RestContext.response.responsebody=Blob.valueOf('{"status":"failed","reason":"'+e.getMessage()+'"}');
         }
         
         if(isSuccess){
            RestContext.response.responsebody=Blob.valueOf('{"status":"success","recordId":"'+a.Id+'"}');
         }
   }

   class AccountData{
      public String account_name;
      public String account_revenue;
      public ContactData contact_record;
   }
   
   class ContactData {
      public String lastname;
      public String phone;
      public String email;
   }
}


