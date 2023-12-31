//Generated by wsdl2apex

public class MySOAPWebservice {
    public class Add_element {
        public Integer a;
        public Integer b;
        private String[] a_type_info = new String[]{'a','http://Example.org',null,'0','1','false'};
        private String[] b_type_info = new String[]{'b','http://Example.org',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://Example.org','true','false'};
        private String[] field_order_type_info = new String[]{'a','b'};
    }
    public class Subtract_element {
        public Integer a;
        public Integer b;
        private String[] a_type_info = new String[]{'a','http://Example.org',null,'0','1','false'};
        private String[] b_type_info = new String[]{'b','http://Example.org',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://Example.org','true','false'};
        private String[] field_order_type_info = new String[]{'a','b'};
    }
    public class SubtractResponse_element {
        public Integer result;
        private String[] result_type_info = new String[]{'result','http://Example.org',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://Example.org','true','false'};
        private String[] field_order_type_info = new String[]{'result'};
    }
    public class AddResponse_element {
        public Integer result;
        private String[] result_type_info = new String[]{'result','http://Example.org',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://Example.org','true','false'};
        private String[] field_order_type_info = new String[]{'result'};
    }
    public class ICalculator {
        public String endpoint_x = 'http://Example.org/ICalculator';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://Example.org', 'MySOAPWebservice'};
        public Integer Add(Integer a,Integer b) {
            MySOAPWebservice.Add_element request_x = new MySOAPWebservice.Add_element();
            request_x.a = a;
            request_x.b = b;
            MySOAPWebservice.AddResponse_element response_x;
            Map<String, MySOAPWebservice.AddResponse_element> response_map_x = new Map<String, MySOAPWebservice.AddResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://Example.org/ICalculator/Add',
              'http://Example.org',
              'Add',
              'http://Example.org',
              'AddResponse',
              'MySOAPWebservice.AddResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.result;
        }
        public Integer Subtract(Integer a,Integer b) {
            MySOAPWebservice.Subtract_element request_x = new MySOAPWebservice.Subtract_element();
            request_x.a = a;
            request_x.b = b;
            MySOAPWebservice.SubtractResponse_element response_x;
            Map<String, MySOAPWebservice.SubtractResponse_element> response_map_x = new Map<String, MySOAPWebservice.SubtractResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://Example.org/ICalculator/Subtract',
              'http://Example.org',
              'Subtract',
              'http://Example.org',
              'SubtractResponse',
              'MySOAPWebservice.SubtractResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.result;
        }
    }
}