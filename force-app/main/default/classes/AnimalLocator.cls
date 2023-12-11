public class AnimalLocator {
    
    public static String getAnimalNameById (Integer id) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+id);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        String animalName=null;
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
            // Deserializes the JSON string into collections of primitive data types.
            // {
            /*  "animal": {
                "id": 1,
                "name": "chicken",
                "eats": "chicken food",
                "says": "cluck cluck"
              }
            }*/
            //results{key=animal, value = {
                //"id": 1,
                //"name": "chicken",
                //"eats": "chicken food",
                //"says": "cluck cluck"
              //}}
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Cast the values in the 'animals' key as a list
			/*animals = {
                "id": 1,
                "name": "chicken",
                "eats": "chicken food",
                "says": "cluck cluck"
              }*/ 
            Object animals = (Object) results.get('animal');
            /*
			 * m[{key=Id, value=1},{key=name, value=chicken},{key=eats, value=chicken food},{key=says, value=cluck cluck}]
             * 
             */
            Map<String,Object> m = (map<String,Object>) animals;
            System.debug('Received the following animals:');
            animalName= (String)m.get('name'); 
        }
        return animalName;
    }        
}