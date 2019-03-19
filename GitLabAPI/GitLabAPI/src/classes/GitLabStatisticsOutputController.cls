public class GitLabStatisticsOutputController {
	@AuraEnabled
	public static StatisticsWrapper makeCalloutToGetStatistics(StatisticsWrapper project) {
		
		project.bestCommiter = GitLabUtils.makeCalloutToGetMostActiveCommiter(project.projectId);
		return project;
	}
}