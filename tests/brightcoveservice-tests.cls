//String access_token_results = BrightcoveService.ObtainAccessToken();
//System.debug(LoggingLevel.INFO,'\n\nAccess Token Results: ' + access_token_results + '\n\n');
List<Brightcove.Folder> folderList = BrightcoveService.ObtainFolderList(0);
System.debug(LoggingLevel.INFO,'\n\nFoler List Results: ' + JSON.serialize(folderList) + '\n\n');
List<Brightcove.Video> videoList = BrightcoveService.ObtainVideosInFolder(folderList[0].id,0);
System.debug(LoggingLevel.INFO,'\n\nVideo List Results: ' + JSON.serialize(videoList) + '\n\n');