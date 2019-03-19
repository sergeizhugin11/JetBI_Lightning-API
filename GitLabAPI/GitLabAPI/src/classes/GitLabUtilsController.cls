public class GitLabUtilsController {
	@AuraEnabled   
	public static String makeCalloutToCreateProject(String folderName) {
		return GitLabUtils.makeCalloutWithAccessToken(folderName);
	}
}