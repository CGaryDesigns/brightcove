/**
 * @description - The purpose of this class is to provide helper classes and 
 *                methods to assist with the user functionality of the Brightcove
 *                Navigation Component
 **/
global class BrightcoveNavController {
    @AuraEnabled
    public class FolderBreadcrumb {
        @AuraEnabled 
        public String label { get; set; }
        @AuraEnabled 
        public String folderId { get; set; }
    }

}
