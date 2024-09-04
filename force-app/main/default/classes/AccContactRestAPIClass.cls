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
         Boolean isSuccess = true;
         try {
            insert a;
         } catch (Exception e) {
            isSuccess = false;
            RestContext.response.responsebody=Blob.valueOf('{"status":"failed","reason":"'+e.getMessage()+'"}');
         }
         
      // System.debug('Request body===>'+RestContext.request.requestbody) ;
         if(isSuccess){
            RestContext.response.responsebody=Blob.valueOf('{"status":"success","recordId":"'+a.Id+'"}');
         }
    }
    public class AccountData{
        public String account_name;
        public String account_revenue;
        publc class ContactData {
            public String lastname;
            public String phone;

        }
    }
}