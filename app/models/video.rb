class Video < ActiveRecord::Base
  has_many :video_attachments, :class_name => "VideoAttachment" , :dependent => :destroy 
  has_many :videoable, :through => :video_attachments



def self.create_with_url(url)
 video_id = parse_youtube(url)
 logger.debug("Finde Me: videoID: " + video_id)
 if(video_id != nil)
   find_or_create_by_url(video_id) 
 end
end


def self.parse_youtube(url) 
  regex = /^(?:http:\/\/)?(?:www\.)?\w*\.\w*\/(?:watch\?v=)?((?:v\/)?[\w\-]+)/
   if(url.start_with?("http://youtu.be/","http://www.youtube.com/watch?v="))
	  url.match(regex)[1] 
   elsif(url.start_with?("http://www.youtube.com/v/"))
      video_id  = parse_youtube url 
      video_id.match(/^v\/([\w\-]+)/)[1]
   end   
end


end