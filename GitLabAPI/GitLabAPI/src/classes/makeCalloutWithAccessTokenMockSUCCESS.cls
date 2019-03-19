@isTest
global class makeCalloutWithAccessTokenMockSUCCESS implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('SUCCESS');
        response.setStatusCode(201);
        return response; 
    }
}