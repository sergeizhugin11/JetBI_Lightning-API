@isTest
	global class makeCalloutWithAccessTokenMockERROR implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('ERROR');
        response.setStatusCode(200);
        return response; 
    }
}