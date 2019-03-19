@isTest
global class makeCalloutToGetAccessTokenMock implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"access_token": "1234567890"}');
        response.setStatusCode(201);
        return response; 
    }
}
