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
    private static String ACCOUNT_ID;

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
            ACCOUNT_ID = '1464976798001';
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
    /**
     * @description: The purpose of this method is to get the full list of folders from Brightcove.
     *               the key thing to note is that the method can can only return 100 records at a
     *               time, so if there are more than that, then it will need to be called with an
     *               offset to get the other items
     * @param Integer offset - this is the offset to pass into the API as a parameter.
     * @return List<Brightcove.Folder> list of folder objects returned.
     **/
    public static List<Brightcove.Folder> ObtainFolderList(Integer offset){
        List<Brightcove.Folder> folderList;
        //first get the Access token
        String access_token;
        try{
            access_token = ObtainAccessToken();
        }catch(System.Exception ex){
            throw ex;
        }
        //lets build the folder URL
        String folderRequestUrl = CMS_API_ENDPOINT + '/accounts/' + ACCOUNT_ID + '/folders?limit=50';
        if(offset != null && offset > 0){
            folderRequestUrl += '&offset=' + offset;
        }
        //now lets build the folder Request
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint(folderRequestUrl);
        req.setHeader('Content-Type','application/json');
        req.setHeader('Authorization','Bearer ' + access_token);
        HttpResponse res;
        Http svc = new Http();
        try{
            res = svc.send(req);
            if(res.getStatusCode() != 200) throw new Brightcove.GeneralException('There was a problem getting folders. Status Code: ' + res.getStatusCode());
            folderList = (List<Brightcove.Folder>)JSON.deserialize(res.getBody(), List<Brightcove.Folder>.class);
        }catch(System.Exception ex){
            throw new Brightcove.GeneralException('There was an error obtaining the folders: ' + ex.getMessage());
        }
        return folderList;
    }
    /**
     * @description: The purpose of this method is to get the full list of all of the videos 
     *               within a folder. The key thing to note is that this method can only
     *               return 20 videos at a time, so if a folder has more than 20 videos,
     *               then this method will need to be called with an offset to get the next
     *               videos
     * @param String folderId                   -the folder Id to use
     * @param integer offset                    - the offset to retrieve the videos starting at.
     * @return List<Brightcove.Video>           -the list of videos that are returned.
     **/
    public static List<Brightcove.Video> ObtainVideosInFolder(String folderId, Integer offset){
        if(String.isEmpty(folderId)) throw new Brightcove.GeneralException('The folder Id cannot be blank.');
        List<Brightcove.Video> videoList;
        //first get the access_token
        String access_token;
        try{
            access_token = ObtainAccessToken();
        } catch(System.Exception ex) {
            throw ex;
        }
        String videoUrl = CMS_API_ENDPOINT + '/accounts/' + ACCOUNT_ID + '/folders/' + folderId + '/videos?limit=30';
        if(offset != null && offset > 0){
            videoUrl += '&offset=' + offset;
        }
        //now lets build the video request
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint(videoUrl);
        req.setHeader('Content-Type','application/json');
        req.setHeader('Authorization','Bearer ' + access_token);
        HttpResponse res;
        Http svc = new Http();
        try {
            res = svc.send(req);
            if(res.getStatusCode() != 200) throw new Brightcove.GeneralException('There was a problem getting videos: Error Code: ' + res.getStatusCode() + ' - ' + res.getBody());
            System.debug(LoggingLevl.INFO,'\n\nVideo Data Returned: ' + res.getBody() + '\n\n');
            videoList = (List<Brightcove.Video>)JSON.deserialize(res.getBody(), List<Brightcove.Video>.class);
        } catch(System.Exception ex) {
            throw new Brightcove.GeneralException('There was an error obtaining the videos: ' + ex.getMessage());
        }
        return videoList;
    }
}
