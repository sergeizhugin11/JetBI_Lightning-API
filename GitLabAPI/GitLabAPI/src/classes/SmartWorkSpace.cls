@RestResource(urlMapping='/Sensor/*')
global with sharing class SmartWorkSpace {
    @HttpPost
	global static string createSensor(String sensorid, Integer[] line) {
        string returnString = 'Sensor created successfully';
        if(line.size() != 12) {
            returnString = 'ERROR: Check number of coords';
            return returnString;
        }
   		List<Sensor__c> sensor = [SELECT Name, Max_Vectors_Difference__c, (select id, x__c, y__c, z__c FROM Sensor_Events__r )
                       FROM Sensor__c
                       WHERE Name =:sensorid];
    	if(!sensor.isEmpty()) {
			delete sensor[0].Sensor_Events__r;
        	update sensor;
		}
        else {
        	sensor.add(new Sensor__c());
            sensor[0].Name = sensorid;
            insert sensor;
      	}
        List<Sensor_Event__c> eveList = new List<Sensor_Event__c>();
        Sensor_Event__c eve = new Sensor_Event__c();
        integer iteration = 0;
        for(integer i = 0; i<line.size()/3;i++) {
        	eve.x__c = line[iteration];
            eve.y__c = line[iteration+1];
            eve.z__c = line[iteration+2];
            eve.Sensor__c = sensor[0].Id;
            iteration += 3;
            eveList.add(eve);
           	eve = new Sensor_Event__c();
		}
       	insert eveList;          
        return returnString;
    }
}