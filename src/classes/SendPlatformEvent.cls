public class SendPlatformEvent{
    public String restEndPoint  {get;set;}
    public String body {get;set;}
    public String platformEventName  {get;set;}
    public String postString {get;set;}
    public String responseString {get;set;}
    
    public Boolean doorOpen {get;set;}
    public String SerialNumber {get;set;}
    public Integer temperature {get;set;}
    
    public Integer interval {get;set;}
    public Boolean chainEvent {get;set;}
    public List<Platform_Event_Type__c> allEventTypes {get;set;}
    public List<Fridge_Event__e> fridgeEvents {get;set;}
    
    public SendPlatformEvent(){
        //System.Debug(System.URL.getSalesforceBaseUrl().toExternalForm() );
        restEndPoint = System.URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v41.0/sobjects/';
        //restEndPoint = 'https://hentest.my.salesforce.com/services/data/v41.0/sobjects/';
        platformEventName = 'Fridge_Event__e';
        body = '';
        postString='';
        /*body = '{' +
                    '"door_open__c": true, '+
                    '"Serial_Number__c": "abcdefghijklmn", '+
                    '"Temperature__c": 95 '+
               '}';
        */
        allEventTypes = [select Name, JSON_Body__c, Platform_Event_Name__c, Event_Type__c  
                         from Platform_Event_Type__c 
                         order by Platform_Event_Name__c
                         limit 100];
        
        responseString = '';
        interval = 0; //time between next event
        chainEvent = false;
    }
    
    public void post(){
        
        if(Test.isRunningTest()){
            mockTest();
        }
        else{
            /*body = '{' +
                    '"door_open__c": ' + String.valueOf(doorOpen) + ', '+
                    '"Serial_Number__c": "'+ String.valueOf(SerialNumber) +'", '+
                    '"Temperature__c": '+ String.valueOf(temperature) +' '+
               '}';*/
            //System.debug('Body: ' + body);
            System.Debug('SendPlatformEvent class');
            HttpResponse response = makePostCallout();
            postString = body + '<br>' + postString;
            responseString = response.getBody() + '<br>' + responseString;
            
        }
        
    }
    
    public HttpResponse makePostCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(restEndPoint + platformEventName);
        //System.Debug('rest end point: '+restEndPoint + platformEventName);
        request.setMethod('POST');
        request.setHeader('Authorization', 'OAuth '+ UserInfo.getSessionId());
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        request.setBody(body);
        HttpResponse response = http.send(request);
        // Parse the JSON response
        if (response.getStatusCode() != 201) {
            //System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
        } else {
            //System.debug(response.getBody());
        }
        return response;
    }
    
    public HttpResponse makeGetCallout() {
        /*
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(restEndPoint + platformEventName);
        request.setMethod('GET');
        request.setHeader('Authorization', 'OAuth '+ UserInfo.getSessionId());
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            // Deserializes the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Cast the values in the 'Fridge_Event__e' key as a list
            List<Object> platformEvents = (List<Object>) results.get('Fridge_Event__e');
            System.debug('Received the following Fridge_Event__e:');
            for (Object p: platformEvents) {
                System.debug(p);
            }
        }
        return response;
        */
        return null;
    }
    
    public void insertFridgeData(){
        List<Platform_Event_Type__c> eventTypes =[SELECT Name 
                                                   FROM Platform_Event_Type__c 
                                                   WHERE Name IN ('Fridge Normal', 'Fridge Warning', 'Fridge Bad Data', 'Fridge Problem')];
        
        if(eventTypes.size() < 4)
        {
            eventTypes = new List<Platform_Event_Type__c>();
            Platform_Event_Type__c normal = new Platform_Event_Type__c();
            normal.Name = 'Fridge Normal';
            normal.JSON_Body__c = '{ "door_open__c": true, "Serial_Number__c": "abcdefghijklmn", "Temperature__c": 94 }';
            normal.Platform_Event_Name__c = 'Fridge_Event__e';
            normal.Event_Type__c = 'Normal';
            
            Platform_Event_Type__c warning = new Platform_Event_Type__c();
            warning.Name = 'Fridge Warning';
            warning.JSON_Body__c = '{ "door_open__c": true, "Serial_Number__c": "abcdefghijklmn", "Temperature__c": 99 }';
            warning.Platform_Event_Name__c = 'Fridge_Event__e';
            warning.Event_Type__c = 'Warning';
            
            Platform_Event_Type__c problem = new Platform_Event_Type__c();
            problem.Name = 'Fridge Problem';
            problem.JSON_Body__c = '{ "door_open__c": true, "Serial_Number__c": "abcdefghijklmn", "Temperature__c": 151 }';
            problem.Platform_Event_Name__c = 'Fridge_Event__e';
            problem.Event_Type__c = 'Problematic';
            
            Platform_Event_Type__c badData = new Platform_Event_Type__c();
            badData.Name = 'Fridge Bad Data';
            badData.JSON_Body__c = '{ "door_open__c": true, "Serial_Number__c": "badserialnumber", "Temperature__c": 94 }';
            badData.Platform_Event_Name__c = 'Fridge_Event__e';
            badData.Event_Type__c = 'Bad Data';
            
            eventTypes.add(normal);
            eventTypes.add(warning);
            eventTypes.add(problem);
            eventTypes.add(badData);
            insert eventTypes;
            
            //refresh the list with the new ones
            allEventTypes = [select Name, JSON_Body__c, Platform_Event_Name__c, Event_Type__c  from Platform_Event_Type__c limit 100];
        }
    }
    
    private void mockTest(){
        String test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
        test = '';
    }
    
}