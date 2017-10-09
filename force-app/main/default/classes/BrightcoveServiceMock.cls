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
        HttpResponse res = new HttpResponse();
        res.setStatus('ERROR');
        res.setStatusCode(404);
        res.setHeader('Content-Type','application/json');
        //get the request, parse the url of the request, attempt to determine the 
        //request
        Url requestedEndUrl = new Url(req.getEndpoint());
        String urlPath = requestedEndUrl.getPath();
        if(urlPath.endsWith('/access_token')){
            res.setStatus('SUCCESS');
            res.setStatusCode(200);
            res.setHeader('Content-Type','application/json');
            res.setBody(AccessTokenResponse());
        } else if(urlPath.contains('folders?limit=50')) {
            res.setStatus('SUCCESS');
            res.setStatusCode(200);
            res.setHeader('Content-Type','application/json');
            res.setBody(FolderListResponse());
        }
        return res;
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
    private static String FolderListResponse(){
        List<Brightcove.Folder> folderObj = new List<Brightcove.Folder>();
        for(Integer i=0;i<3;i++){
            Brightcove.Folder folderTest = new Brightcove.Folder();
            folderTest.account_id = '123455';
            folderTest.created_at = '2017-01-01 12:00:00.000';
            folderTest.name = GenerateRandomString(10);
            folderTest.id = GenerateRandomString(8);
            folderTest.version = 1;
            folderTest.updated_at = Date.today().format();
            folderTest.video_count = 20;
            folderObj.add(folderTest);
        }
        return JSON.serialize(folderObj);
    }
    private static String GenerateRandomString(Integer charLength){
        List<String> charBucket = new List<String>{'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q',
                                                   'r','s','t','u','v','w','x','y','z'};
        String finalString = '';
        for(Integer i=0;i<charLength;i++){
            finalString += charBucket.get(Integer.valueOf(Math.floor(Math.random() * charBucket.size())));
        }
        return finalString;

    }
}
