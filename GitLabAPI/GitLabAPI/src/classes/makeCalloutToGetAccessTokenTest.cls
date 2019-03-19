@isTest
public class makeCalloutToGetAccessTokenTest  {
	@isTest 
	public static void testPostCalloutAccess() {
		Test.setMock(HttpCalloutMock.class, new makeCalloutToGetAccessTokenMock()); 
		String actualValue = GitLabUtils.makeCalloutToGetAccessToken('12');
		System.assertEquals(actualValue, '1234567890');
	}
}