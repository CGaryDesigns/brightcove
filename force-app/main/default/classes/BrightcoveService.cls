/**
 * @description: This class is responsible for providing direct interaction
 *               with the Brightcove API Services.
 * @author: Cloud Performer <cgary@cloudperformer.com>
 * @version 1.0
 **/
global class BrightcoveService {
    private static String CLIENT_ID;
    private static String CLIENT_SECRET;
    private static String CMS_API_ENDPOINT;
    private static String OAUTH_API_ENDPOINT;

    /**
     * @description: this constructor is used to set the values of the static
     *               variables in the class upon first initialization.
     **/               
    static {
        StreamContentManagerSetting__mdt metaDataSetting;
        try{
            metaDataSetting = [SELECT Id, Label, ClientId__c, ClientSecret__c, EndpointUrl__c FROM StreamContentManagerSetting__mdt WHERE Label = 'Brightcove'];
            CLIENT_ID = metaDataSetting.ClientId__c;
            CLIENT_SECRET = metaDataSetting.ClientSecret__c;
            Url baseEndpoint = new Url(metaDataSetting.EndpointUrl__c);
            CMS_API_ENDPOINT  = 'https://cms.api.' + baseEndpoint.getHost() + '/v1';
            OAUTH_API_ENDPOINT = 'https://oauth.' + baseEndpoint.getHost() + '/v4';
        } catch(System.Exception ex){
            throw new Brightcove.GeneralException(ex.getMessage());
        }
    }
    /**
     * @description: the purpose of this method is to get a valid access token in order
     *               to make a valid API Call. The access token expures every 5 minutes,
     *               so instead of taking the trouble to determine if the access toekn is 
     *               resuable, we might as well get a new one every time. Getting a new
     *               access token does involve making an HTTP Callout, so this might take
     *               a sec.
     * @return: String - the access token obtained after making the Auth Call.
     **/
    public static String ObtainAccessToken(){
        String access_token;
        //we need to build the request for the Access Token Call
        //this involves creating the Header and the Body for a post reqiest
        //create the Authorization Header
        String authorizationHeader = EncodingUtil.base64Encode(Blob.valueOf(CLIENT_ID + ':' + CLIENT_SECRET));
        String requestBody = 'grant_type=client_credentials';
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint(OAUTH_API_ENDPOINT + '/access_token');
        req.setBody(requestBody);
        req.setHeader('Authorization','Basic ' + authorizationHeader);
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        HttpResponse res;
        Http svc = new Http();
        try{
            res = svc.send(req);
            if(res.getStatusCode() != 200) throw new Brightcove.GeneralException('Response Error: ' + res.getStatusCode() + '\nDetails: ' + res.getBody());
            //parse the response and get out the access token 
            Map<String,Object> objResultMap = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
            access_token = String.valueOf(objResultMap.get('access_token'));
        }catch(System.Exception ex){
            throw new Brightcove.GeneralException('There was a problem getting the access token: ' + ex.getMessage());
        }

        return access_token;
    }
}
