public class EmployeeCallout {
    
    @future(Callout=true)
    public static void fetchEmployees(List<Id> accountIds){
        List<Employee__c> employees = new List<Employee__c>();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://dummy.restapiexample.com/api/v1/employees');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Cast the values in the 'animals' key as a list
            List<Object> datas = (List<Object>) results.get('data');
            System.debug('Received the following animals:');
            for(Object data: datas) {
                
                Map<String,Object> employeeData = (Map<String,Object>)data;
                if(employeeData.get('id')!=null && accountIds!=null){
                    Employee__c emp = new Employee__c();
                    emp.employee_Id__c = (employeeData.get('id') ==null)? '0': String.valueOf(employeeData.get('id'));
                    emp.Account__c = accountIds[0];
                    employees.add(emp);
                    System.debug(data);
                }                
            }
        } 
        
        insert employees;
        
    }
    
}