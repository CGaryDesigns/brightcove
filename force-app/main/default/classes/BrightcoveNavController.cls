/**
 * @description - The purpose of this class is to provide helper classes and 
 *                methods to assist with the user functionality of the Brightcove
 *                Navigation Component
 **/
global class BrightcoveNavController {
    /**
     * Constructor
     **/
    public BrightcoveNavController(){}
    /**
     * @description: the purpose of this method is to provide a list of folders
     *               from the Brightcove Account.
     * @param Integer offset    the start record to begin the return of folders.
     * @return List<Brightcove.Folder> the list of folders that are returned.
     **/
    @RemoteAction
    public static List<Brightcove.Folder> GetFolderList(Integer offset){
        List<Brightcove.Folder> folderList;
        try{
            folderList = BrightcoveService.ObtainFolderList(offset);
        }catch(System.Exception ex){
            //there was a problem obtaining the information
            throw ex;
        }
        return folderList;
    }
}
