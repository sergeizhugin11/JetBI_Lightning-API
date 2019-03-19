public with sharing class ApplicationController {
    
    public class fieldWrapper {
        string xc;
        string yc;
        string zc;
    }
    
	@AuraEnabled       
    public static List<String> OutputPicklist(){
       	List<Sensor__c> sensors = [SELECT Name FROM Sensor__c LIMIT 50];    
        Set<string> setSensorsName = new Set<string>();
        for(Sensor__c item : sensors) {
            setSensorsName.add(item.Name);
        }
		List<string> picklistName = new List<string>();
        for(String item : setSensorsName) {
            picklistName.add(item);
        }
        return picklistName;
    }  
    @AuraEnabled
	public static Sensor__c ViewName(String recordName){
		Sensor__c sensor = [SELECT Name, Max_Vectors_Difference__c
                       FROM Sensor__c
                       WHERE Name =:recordName];
        return sensor;
	}
	@AuraEnabled
	public static Sensor_Event__c[] ViewEvents(String recordName){
		Sensor__c sensor = [SELECT (select id, x__c, y__c, z__c FROM Sensor_Events__r )
                       FROM Sensor__c
                       WHERE Name =:recordName];
        return sensor.Sensor_Events__r;
	}
    @AuraEnabled
	public static Sensor_Event__c[] UpdateEvents(string recordName, string JSONstring){
    	Sensor__c sensor = [SELECT Name,Max_Vectors_Difference__c, (select id, x__c, y__c, z__c FROM Sensor_Events__r )
                       FROM Sensor__c
                       WHERE Name =:recordName];
       	delete sensor.Sensor_Events__r;

       	List<Sensor_Event__c> listEvent = new List<Sensor_Event__c>();
        List<fieldWrapper> listWrapper = (List<fieldWrapper>) JSON.deserialize(JSONstring, List<fieldWrapper>.class);
        for(fieldWrapper wrapper: listWrapper) {
        	Sensor_Event__c sensorEvent = new Sensor_Event__c();
            sensorEvent.x__c = decimal.valueOf(wrapper.xc);
            sensorEvent.y__c = decimal.valueOf(wrapper.yc);
            sensorEvent.z__c = decimal.valueOf(wrapper.zc);
            sensorEvent.Sensor__c = sensor.Id;
            listEvent.add(sensorEvent);
		}
       	insert listEvent;
        return sensor.Sensor_Events__r;
	}
}