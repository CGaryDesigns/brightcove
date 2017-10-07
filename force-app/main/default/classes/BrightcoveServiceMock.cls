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
        return null;
    }
}
