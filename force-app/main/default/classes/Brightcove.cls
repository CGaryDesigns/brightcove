/**
 * @description: The purpose of this class is to provide an object library
 *               to facilitate receiving and sending data to the Brightcove 
 *               API's.
 * @author: Cloud Performer <cgary@cloudpderformer.com>
 * @version: 1.0
 **/
global class Brightcove {
    public class GeneralException extends Exception {}

    /**
     * @description: This class is a representation of the object expected
     *               to come back representing a folder.
     **/
    public class Folder { 
        public String id { get; set; }
        public String account_id { get; set; }
        public String name { get; set; }
        public String created_at { get; set; }
        public Integer video_count { get; set; }
        public Integer version { get; set; }
        public String updated_at { get; set; }
    }

    /**
     * @description: This class is a representation of the video object expected
     *               to come back representing a video.
     **/
    public class Video {
        public String account_id { get; set; }
        public String ad_keys { get; set; }
        public String clip_source_video_id { get; set; }
        public Boolean complete { get; set; }
        public Long created_at { get; set; }
        public List<Brightcove.CuePoint> cue_points { get; set; }
        public String custom_fields { get; set; }
        public String manifest_id { get; set; }
        public String description { get; set; }
        public String digital_master_id { get; set; }
        public Long milliseconds { get; set; }
        public String economics { get; set; }
        public String folder_id { get; set; }
        public Map<String,Brightcove.Geo> geo { get; set; }
        public Boolean has_digital_master { get; set; }
        public String id { get; set; }
        public Map<String,Brightcove.Image> images { get; set; } 
        public String long_description { get; set; }
        public String name { get; set; }
        public Boolean offline_enabled { get; set; }
        public String original_filename { get; set; }
        public String projection { get; set; }
        public String published_at { get; set; }
        public String reference_id { get; set; }
        public Brightcove.Schedule schedule { get; set; }
        public String smooth_client_manifest_id { get; set; }
        public String smooth_server_manifest_id { get; set; }
        public String state { get; set; }
        public List<String> tags { get; set; }
        public String updated_at { get; set; }

    }
    public class CuePoint { 
        public String id { get; set; }
        public Boolean force_stop { get; set; }
        public String metadata { get; set; }
        public String name { get; set; }
        public String type { get; set; }
    }
    public class Geo { 
        public List<String> countries { get; set; }
        public Boolean exclude_countries { get; set; }
        public Boolean restricted { get; set; }
    }
    public class Image { 
        public String asset_id { get; set; }
        public Boolean remote { get; set; }
        public String src { get; set; }
    }
    public class Schedule { 
        public String ends_at { get; set; }
        public String starts_at { get; set; }
    }
}

