public class ProjectStatisticController  {
	@AuraEnabled
	public static List<CommitsWrapper> getProjectCommits(String projectId) {
		return GitLabUtils.makeCalloutToGetCommits(projectId);
	}
}