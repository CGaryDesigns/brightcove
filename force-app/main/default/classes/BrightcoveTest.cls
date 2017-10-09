/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class BrightcoveTest {

    @isTest
    static void GeneralException(){
        Test.startTest();
        try{
            throw new Brightcove.GeneralException('This is a test');
        }catch(Brightcove.GeneralException ex){
            System.assertEquals('This is a test', ex.getMessage());
        }
        Test.stopTest();
    }

    @isTest
    static void Folder(){
        Test.startTest();
        Brightcove.Folder testObj = new Brightcove.Brightcove.Folder();
        testObj.id = '12345';
        testObj.account_id = '3rgqrwtw5gw3rgw3g3';
        testObj.name = 'Test Folder';
        testObj.created_at = '2017-01-01 12:35:17.000';
        testObj.video_count = 123;
        testObj.version = 1;
        testObj.updated_at = '2017-01-02 13:00:00.000';
        Test.stopTest();
    }

    @isTest
    static void Schedule(){
        Test.startTest();

        Brightcove.Schedule testObj = new Brightcove.Schedule();
        testObj.ends_at = '2017-12-31 12:00:00.000';
        testObj.starts_at = '2017-01-01 12:00:00.000';

        Test.stopTest();
    }

    @isTest
    static void Image(){
        Test.startTest();

        Brightcove.Image img = new Brightcove.Image();
        img.asset_id = '123456';
        img.remote = false;
        img.src = 'http://www.google.com/image.png';

        Test.stopTest();
    }

    @isTest
    static void Geo(){
        Test.startTest();

        Brightcove.Geo testObj = new Brightcove.Geo();
        testObj.countries = new List<String>();
        testObj.exclude_countries = false;
        testObj.restricted = false;

        Test.stopTest();
    }

    @isTest
    static void CuePoint(){
        Test.startTest();

        Brightcove.CuePoint testObj = new Brightcove.CuePoint();
        testObj.id = '48y9284298';
        testObj.force_stop = false;
        testObj.metadata = 'test1=foo&test2=bar';
        testObj.name = 'Cue_point_1';
        testObj.type = 'Video';

        Test.stopTest();
    }
}