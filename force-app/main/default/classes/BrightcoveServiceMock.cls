/**
 * @description: The purpose of this class is to use an way to 
 *               devlier moch Http Responses from the Brightcove
 *               service during the UnitTests of the BrightcoveService
 *               methods. Because salesforce cannot actually perform
 *               Http Callouts while running test methods, instead this 
 *               class is run in order to simulate responses during testing.
 * @author: Cloud Performer <cgary@cloudperformer.com>
 * @version: 1.0
 **/
@isTest
global class BrightcoveServiceMock implements HttpCalloutMock {
    /**
     * @description:    implementation of the required respond method
     * @param HttpRequest req   the request that is going to be passed in
     * @return HttpResponse      the simulated HttpResponse
     **/
    global HttpResponse respond(HttpRequest req){
        HttpResonse res = new HttpResponse();
        res.setStatus('ERROR');
        res.setStatusCode(404);
        res.setHeader('Content-Type','application/json');
        //get the request, parse the url of the request, attempt to determine the 
        //request
        Url requestedEndUrl = new Url(req.getEndpoint());
        String urlPath = requestedEndUrl.getPath();
        if(urlPath == '/v4/access_token'){
            res.setStatus('SUCCESS');
            res.setStatusCode(200);
            res.setHeader('Content-Type','application/json');
            res.setBody(AccessTokenResponse());
        }
        return null;
    }

    private static String AccessTokenResponse(){
        JSONGenerator gen = JSON.createGenerator(false);
        gen.writeStartObject();                 
            gen.writeStringField('access_token', 'AOg5ybI0uo-udBOuLjafk6WTJgDZUMPzpEQLk06_yS24LMR6PQO0SMnT6vk1beLIEAMYaxIA6NlfkFCIA2hgWmsXmSAb1ZHYRiunLnxX1EZ0Qu2MktGXAz-z6g7eR-w1580-2U_hjMIxN7Rsh0TU5EezlJR6gk2g5gZMZA5PIJREr9dbdYBRO6y7YJkh1ExAJr-OjQFuKtE65NEl_S4gE9Cy_7qBiWJ0Q5DT6O5PXfjvMvozfATJT8qxzXK0x-JWxTD1dm84eAL4dzmkkiuy3b--p7cCNBkvfMSF43CA724WrrixCPntJhtmPRlIhNgwOc9hAWWILEIaXWasdxGSeRhmEdAPMm8G62bt26gybbEIeOFzHAZ1ij-uGt-cLGgJ4TuUVMgZ0hsNsIaUciUnNnAdufiod70JJ5qPPZ8vbFSck4redM1nMTql_kwu77zeWq484DZvjRgdbjREUha6KVgdd5nL6FCerx-6wjtHSqT84TBmyPt8Ap8');
            gen.writeStringField('token_type','Bearer');
            gen.writeNumberField('expires_in', 300);
        gen.writeEndObject();                   
        return gen.getAsString();
    }
}
