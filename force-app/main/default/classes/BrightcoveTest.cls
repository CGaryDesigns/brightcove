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
        Brightcove.Folder testObj = new Brightcove.Folder();
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
        img.sources = new List<Brightcove.Source>();

        Test.stopTest();
    }

    @isTest
    static void Source(){
        Test.startTest();

        Brightcove.Source testObj = new Brightcove.Source();
        testObj.src = 'http://www.google.com/image.png';
        testObj.height = 100;
        testObj.width = 100;

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

    @isTest
    static void Video(){
        Test.startTest();

        Brightcove.Video testObj = new Brightcove.Video();
        testObj.account_id = '12345';
        testObj.ad_keys = 'test=foo';
        testObj.clip_source_video_id = '4t24052705';
        testObj.complete = false;
        testObj.created_at = '2017-01-01T13:00:00.000';
        testObj.cue_points = new List<Brightcove.CuePoint>();
        testObj.custom_fields = new Map<String,String>();
        testObj.description = 'This is a test';
        testObj.digital_master_id = '8457028t4y20t';
        testObj.economics = 'AD_FREE';
        testObj.folder_id = '923000h20ghr08g';
        testObj.geo = new Map<String,Brightcove.Geo>();
        testObj.has_digital_master = false;
        testObj.id = 'r8gh3g7h39r7gh39g';
        testObj.images = new Map<String,Brightcove.Image>();
        testObj.long_description = 'This is a test';
        testObj.name = 'Test Obj';
        testObj.original_filename = 'test.mp4';
        testObj.projection = 'This is a test';
        testObj.published_at = '2017-01-01T12:00:00.000Z';
        testObj.reference_id = '2408th20r8h308rg';
        testObj.schedule = new Brightcove.Schedule();
        testObj.state = 'ACTIVE';
        testObj.tags = new List<String>();
        testObj.updated_at = '2017-01-01T12:00:00.000';

        Test.stopTest();
    }
}