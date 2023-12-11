public class AnimalTriggerWebserice {
    
    @future(callout=true)
    public static void invokeAnimalWebservice(){
        makeCallout();
    }
    
    public static HttpResponse makeCallout(){
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped('{"animals":["majestic badger","fluffy bunny","scary bear","chicken"],"animalsCount":"2","topAnimal":"Malathi","AnimalDisease":["Cold","cough"]}');
            // Cast the values in the 'animals' key as a list
            List<Object> animals = (List<Object>) results.get('animals');
            Object animalsCount = (Object) results.get('animalsCount');
            System.debug('Received the following animals:'+Integer.valueOf( animalsCount));
            System.debug('Received the following animals:');
            for (Object animal: animals) {
                System.debug(animal);
            }
        }
        return response;
        
    }
}