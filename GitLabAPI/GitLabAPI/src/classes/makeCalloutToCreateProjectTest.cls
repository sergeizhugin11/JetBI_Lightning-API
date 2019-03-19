@isTest
public class makeCalloutToCreateProjectTest  {
	@isTest 
	public static void testPostCalloutProjectSUCCESS() {
		Test.setMock(HttpCalloutMock.class, new makeCalloutToCreateProjectMockSUCCESS()); 
		String actualValue = GitLabUtils.makeCalloutToCreateProject('123456');
		System.assertEquals(actualValue, 'SUCCESS');
	}
	@isTest 
	public static void testPostCalloutProjectERROR() {
		Test.setMock(HttpCalloutMock.class, new makeCalloutToCreateProjectMockERROR()); 
		String actualValue = GitLabUtils.makeCalloutToCreateProject('123456');
		System.assertEquals(actualValue, 'ERROR');
	}
}