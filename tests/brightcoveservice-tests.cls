//String access_token_results = BrightcoveService.ObtainAccessToken();
//System.debug(LoggingLevel.INFO,'\n\nAccess Token Results: ' + access_token_results + '\n\n');
List<Brightcove.Folder> folderList = BrightcoveService.GetFolderList(0);
System.debug(LoggingLevel.INFO,'\n\nFoler List Results: ' + JSON.serialize(folderList) + '\n\n');