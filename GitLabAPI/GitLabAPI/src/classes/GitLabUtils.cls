public with sharing class GitLabUtils {
	private static final String APP_ADRESS = 'https://' + GitLabApp__c.getInstance().AppAdress__c;

	private static final String APP_UNIQUE_TOKEN = GitLabApp__c.getInstance().AppUniqueToken__c;
    
	private static final String APP_ID = GitLabApp__c.getInstance().AppId__c;
	private static final String APP_SECRET = GitLabApp__c.getInstance().AppSecret__c;
	private static final String APP_REDIRECT_ADRESS = GitLabApp__c.getInstance().AppRedirectArdress__c;

	private static final String APP_ACCESS_TOKEN = GitLabApp__c.getInstance().AppAccessToken__c;
	private static final String APP_ACCESS_TOKEN_FORMAT = 'client_id={0}&client_secret={1}&code={2}&grant_type=authorization_code&redirect_uri={3}';
	private static final String HEADER_TYPE = 'Content-Type';
	private static final String HEADER_CHARSET_TYPE = 'application/json;charset=UTF-8';

	private final static String URL_FOR_CREATE_WITH_ACCTOKEN = '/api/v4/projects?private_token=';
	private final static String URL_FOR_CREATE_WITH_UNIQE_TOKEN = APP_ADRESS + '/oauth/token';
    private final static String URL_FOR_CREATE_WITH_TOKEN = APP_ADRESS + '/api/v4/projects?access_token=';
	private final static String URL_FOR_POST_BODY1 = '{"name":"';
	private final static String URL_FOR_POST_BODY2 = '"}';
	private final static String URL_FOR_PROJ_INF = APP_ADRESS +'/api/v4/projects/?access_token=' + APP_ACCESS_TOKEN + '&statistics=true&sort=asc'  + '&per_page=1000';
	private final static String URL_FOR_BEST_COMMITER1 = APP_ADRESS +'/api/v4/projects/'; 
	private final static String URL_FOR_BEST_COMMITER2 = '/repository/commits?access_token=' + APP_ACCESS_TOKEN + '&with_stats=true';
	private final static String URL_FOR_PROJ_COMMITS1 = APP_ADRESS +'/api/v4/projects/';	
	private final static String URL_FOR_PROJ_COMMITS2 = '/repository/commits?access_token=' + APP_ACCESS_TOKEN + '&with_stats=true';

	private final static String POST = 'POST';
	private final static String GETT = 'GET';
	private final static String STR_ACCESS_TOKEN = 'access_token';
	private final static String SUCCESS = 'SUCCESS';
	private final static String EMPTY_COMMIT_AUTHOR = 'no one commited it';
	private final static String EMPTY_STR = '';

	private final static String NAMEE = 'name';
	private final static String IDD = 'id';
	private final static String STATISTICS = 'statistics';
	private final static String COMMIT_COUNT = 'commit_count';
	private final static String AUTHOR_NAME = 'author_name';
	private final static String TITLE = 'title';
	private final static String CREATED_AT = 'created_at';
	private final static String STATS = 'stats';
	private final static String ADDITIONS = 'additions';
	private final static String DELETIONS = 'deletions';

	public static String makeCalloutWithAccessToken(string folderName) {
        String restReqest = APP_ADRESS + URL_FOR_CREATE_WITH_ACCTOKEN + APP_UNIQUE_TOKEN;
        return makeCalloutToGitLub(restReqest, folderName);
    }      

	public static String makeCalloutToGetAccessToken(String code) {
        String restReqest = URL_FOR_CREATE_WITH_UNIQE_TOKEN;
        String responseStr = EMPTY_STR;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(restReqest);
        request.setMethod(POST);
		String[] strArr = new String[] {APP_ID, APP_SECRET, code, APP_REDIRECT_ADRESS};
        request.setBody(String.format(APP_ACCESS_TOKEN_FORMAT, strArr));
        HttpResponse response = http.send(request);
		Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
		responseStr = String.valueOf(results.get(STR_ACCESS_TOKEN));
        return responseStr;
    }

	public static string makeCalloutToCreateProject(string folderName) {
        String restReqest = URL_FOR_CREATE_WITH_TOKEN + APP_ACCESS_TOKEN;
        return makeCalloutToGitLub(restReqest, folderName);
    }
	public static String makeCalloutToGitLub(String restReqest, String folderName) {
		String responseStr = EMPTY_STR;
        Http http = new Http();
        HttpRequest request = new HttpRequest(); 
        request.setEndpoint(restReqest); 
        request.setMethod(POST);
        request.setHeader(HEADER_TYPE, HEADER_CHARSET_TYPE);
        request.setBody(URL_FOR_POST_BODY1 + folderName + URL_FOR_POST_BODY2);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() != 201) {
            responseStr += String.valueOf(response.getBody());
        } else {
            responseStr += SUCCESS;
        }
        return responseStr;
	}
	public static List<StatisticsWrapper> makeCalloutToGetProgectInfo() {
		HttpResponse response = httpGETResponse(URL_FOR_PROJ_INF);
		List<Object> listOfProject = (List<Object>) JSON.deserializeUntyped(response.getBody());
		List<StatisticsWrapper> listOfProjectInfo = new List<StatisticsWrapper>();
		for(Object project : listOfProject) {
			StatisticsWrapper w = new StatisticsWrapper();
			Map<String, Object> result = (Map<String, Object>)project;
			w.nameOfProject = String.valueOf(result.get(NAMEE));
			w.projectId = String.valueOf(result.get(IDD));
			Map<String, Object> o = (Map<String, Object>) result.get(STATISTICS);
			w.commits = String.valueOf(o.get(COMMIT_COUNT));
			listOfProjectInfo.add(w);
		}
		System.debug(response.getBody());
		listOfProjectInfo.sort();
        return listOfProjectInfo;
	}

	public static String makeCalloutToGetMostActiveCommiter(string projectId) {
		HttpResponse response = httpGETResponse(URL_FOR_BEST_COMMITER1 + projectId + URL_FOR_BEST_COMMITER2);
		System.debug(response.getBody());
		List<Object> listOfCommits = (List<Object>) JSON.deserializeUntyped(response.getBody());
		if(listOfCommits.isEmpty())
			return EMPTY_COMMIT_AUTHOR;
		Map<Integer, String> listOfAuthors = new Map<Integer, String>();
		for(Object project : listOfCommits) {
			Map<String, Object> result = (Map<String, Object>)project;
			listOfAuthors.put(response.getBody().countMatches(String.valueOf(result.get(AUTHOR_NAME))),String.valueOf(result.get(AUTHOR_NAME)));
		}
		List<Integer> keySet = new List<Integer>();
		keySet.addAll(listOfAuthors.keySet());
		keySet.sort();
		return listOfAuthors.get(keySet[keySet.size()-1]);
	}	

    public static List<CommitsWrapper> makeCalloutToGetCommits(String projectId) {
		HttpResponse response = httpGETResponse(URL_FOR_PROJ_COMMITS1 + projectId + URL_FOR_PROJ_COMMITS2);
        List<Object> listOfObject = (List<Object>) JSON.deserializeUntyped(response.getBody());
		List<CommitsWrapper> listOfCommits = new List<CommitsWrapper>();
		for(Object committ : listOfObject) {
			CommitsWrapper w = new CommitsWrapper();
			Map<String, Object> result = (Map<String, Object>) committ;
			w.commitsName = String.valueOf(result.get(TITLE));
			w.authorName = String.valueOf(result.get(AUTHOR_NAME));
			w.createDate = String.valueOf(result.get(CREATED_AT));
			Map<String, Object> o = (Map<String, Object>) result.get(STATS);
			w.addLines = String.valueOf(o.get(ADDITIONS));
			w.delLines = String.valueOf(o.get(DELETIONS));
			listOfCommits.add(w);
		}
        return listOfCommits;
	}

	public static HttpResponse httpGETResponse(String restReqest) {
		Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(restReqest); 
        request.setMethod(GETT);
        HttpResponse response = http.send(request);
		return response;
	}
}