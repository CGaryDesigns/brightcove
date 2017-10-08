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
        public String created_at { get; set; }
        public Integer video_count { get; set; }
        public Integer version { get; set; }
        public String updated_at { get; set; }
    }
}

