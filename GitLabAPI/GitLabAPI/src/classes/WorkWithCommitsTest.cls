@isTest 
public class WorkWithCommitsTest  {
	@isTest 
	public static void testCalloutToGetMostActiveCommiter() {
		Test.setMock(HttpCalloutMock.class, new WorkWithCommitsMock()); 
		String actualValue = GitLabUtils.makeCalloutToGetMostActiveCommiter('1');
		System.assertEquals(actualValue, 'Sergey');
	}
	@isTest 
	public static void testCalloutToGetEmptyCommiter() {
		Test.setMock(HttpCalloutMock.class, new WorkWithEmptyCommitsMock()); 
		String actualValue = GitLabUtils.makeCalloutToGetMostActiveCommiter('1');
		System.assertEquals(actualValue, 'no one commited it');
	}
	@isTest 
	public static void testCalloutToGetCommits() {
		Test.setMock(HttpCalloutMock.class, new WorkWithCommitsMock()); 
		List<CommitsWrapper> actualValue = GitLabUtils.makeCalloutToGetCommits('1');
		System.assertEquals(actualValue.size()>0, true);
	}
	@isTest 
	public static void testCalloutToGetProjectInfo() {
		Test.setMock(HttpCalloutMock.class, new WorkWithProjectMock()); 
		List<StatisticsWrapper> actualValue = GitLabUtils.makeCalloutToGetProgectInfo();
		System.assertEquals(actualValue.size()>0, true);
	}
}