@isTest
public class makeCalloutWithAccessTokenTest {
	@isTest 
	public static void testPostCalloutSUCCESS() {
		Test.setMock(HttpCalloutMock.class, new makeCalloutWithAccessTokenMockSUCCESS()); 
		String actualValue = GitLabUtilsController.makeCalloutToCreateProject('12');
		
		System.assertEquals(actualValue, 'SUCCESS');
	}
	@isTest 
	public static void testPostCalloutERROR() {
		Test.setMock(HttpCalloutMock.class, new makeCalloutWithAccessTokenMockERROR()); 
		String actualValue = GitLabUtilsController.makeCalloutToCreateProject('11');
		
		System.assertEquals(actualValue, 'ERROR');
	}
}