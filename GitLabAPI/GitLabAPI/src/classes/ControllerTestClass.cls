@IsTest
private class ControllerTestClass {
    static testMethod void testControllerMethods() { 
        Sensor__c sensor = new Sensor__c();
        sensor.Name = '112233';
        insert sensor;
        Sensor_Event__c sensorEvent = new Sensor_Event__c();
        sensorEvent.x__c = 4;
        sensorEvent.y__c = 9;
        sensorEvent.z__c = 36;
        sensorEvent.Sensor__c = sensor.Id;
        insert sensorEvent;
        
        List<String> testWorkspace_01 = ApplicationController.OutputPicklist();
        Sensor__c sensorTest_01 = [SELECT Name FROM Sensor__c];
        System.assertEquals(sensorTest_01.Name, testWorkspace_01[0]);
        
        Sensor_Event__c[] eventTest_01 = ApplicationController.ViewEvents('112233');
        System.assertEquals(4, eventTest_01[0].x__c);
        
        Sensor__c eventTest_02 = ApplicationController.ViewName('112233');
        System.assertEquals(37.32, eventTest_02.Max_Vectors_Difference__c);
        
        ApplicationController.UpdateEvents('112233','[{"Sensorc":"a016F00001tOKP1QAO","Id":"a026F00001UIijOQAT","xc":1000,"yc":45,"zc":14},{"Sensorc":"a016F00001tOKP1QAO","Id":"a026F00001UIijPQAT","xc":22,"yc":43,"zc":196},{"Sensorc":"a016F00001tOKP1QAO","Id":"a026F00001UIijQQAT","xc":24,"yc":12,"zc":99},{"Sensorc":"a016F00001tOKP1QAO","Id":"a026F00001UIijRQAT","xc":99,"yc":78,"zc":"1700"}]');
        Sensor__c sensorTest = [SELECT Name, Max_Vectors_Difference__c, (select id, x__c, y__c, z__c FROM Sensor_Events__r )
                       FROM Sensor__c
                       WHERE Name = '112233'];   
	 	System.assertEquals(1000, sensorTest.Sensor_Events__r[0].x__c);
    }
}