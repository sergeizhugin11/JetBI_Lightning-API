@IsTest
private class RestAPIClassTest
{
    static testMethod void testPostMethod()
    {
        RestRequest request = new RestRequest();
        request.requestUri ='https://sergeizhugin-developer-edition.ap4.force.com/services/apexrest/Sensor';
        request.httpMethod = 'POST';
        RestContext.request = request;
        
        Integer[] coordsArray_01 = new Integer[]{1,2,3,4,5,6,7,8,9,0,11,22};
        String testWorkspace_01 = SmartWorkSpace.createSensor('1001', coordsArray_01);
        Sensor__c sensorTest_01 = [SELECT (select id, x__c, y__c, z__c FROM Sensor_Events__r ) FROM Sensor__c WHERE Name = '1001'];
        System.assertEquals(1, sensorTest_01.Sensor_Events__r[0].x__c);
        System.assertEquals('Sensor created successfully', testWorkspace_01);
        
        Integer[] coordsArray_02 = new Integer[]{1000,2,3,4,5,6,7,8,9,0,11,22};
        String testWorkspace_02 = SmartWorkSpace.createSensor('1001', coordsArray_02);
        Sensor__c sensorTest_02 = [SELECT (select id, x__c, y__c, z__c FROM Sensor_Events__r ) FROM Sensor__c WHERE Name = '1001'];
        System.assertEquals(1000, sensorTest_02.Sensor_Events__r[0].x__c);
        System.assertEquals('Sensor created successfully', testWorkspace_02);
        
        Integer[] coordsArray_03 = new Integer[]{1000,100,3,4,5,6,7,8,9,0,11,22,99};
        String testWorkspace_03 = SmartWorkSpace.createSensor('1001', coordsArray_03);
        System.assertEquals('ERROR: Check number of coords', testWorkspace_03);
    }
}