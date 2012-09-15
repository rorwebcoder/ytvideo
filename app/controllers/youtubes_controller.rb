#~ require 'youtube_it'
#~ require 'uri'

class YoutubesController < ApplicationController
		def video_validator
				@status, @message = youtube_url_validator				
				render 'index'
		end		
		
		def youtube_url_validator
				if params[:yt_url].blank?# || params[:yt_url].length != 11
						return false, "Url cannot be blank"
				else
						video_id = extract_video_id
						if video_id
								client = YouTubeIt::Client.new
								begin
										client.video_by(video_id)
										Video.create(:youtube_id => video_id, :is_valid => true)
										return true, "Video found"
								rescue OpenURI::HTTPError
										#~ Video.create(:youtube_id => video_id)
										return false, "Video not found"										
								end
						else
								return false, "Invalid youtube url"
						end						
				end				
		end		
		
		def extract_video_id
				begin
						uri = URI(params[:yt_url])
						params = uri.query.split("&")
						v_param = params.find {|p| p.include?("v=")}
						return v_param.split("v=").last
				rescue
						return nil
				end
		end
		
end
