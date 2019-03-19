public class GitLabStatisticsController {
	@AuraEnabled
	public static List<StatisticsWrapper> makeCalloutToGetProjectInfo() {
		return GitLabUtils.makeCalloutToGetProgectInfo();
	}
}