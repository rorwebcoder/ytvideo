require File.dirname(__FILE__) + '/../spec_helper.rb'

describe YoutubesController do
  render_views
		describe "Index Page" do
				it "should display simple form" do
						get "index"
						response.should be_success
						response.should render_template('index')
				end				
		end
		
		describe "YT Url Validator" do
				it "should create new video record if user enters a valid youtube url" do
						post "video_validator", {:yt_url => "http://www.youtube.com/watch?v=ue1iI5hgVDY&feature=g-logo-xit"}
						response.should be_success
						assigns(:status).should == true
						assigns(:message).should == "Video found"
				end				
				
				it "should display error message if user left url as blank" do
						post "video_validator", {:yt_url => nil}
						response.should be_success
						assigns(:status).should == false
						assigns(:message).should == "Url cannot be blank"
				end				
				
				it "should display error message if url is empty" do
						post "video_validator", {:yt_url => ""}
						response.should be_success
						assigns(:status).should == false
						assigns(:message).should == "Url cannot be blank"
				end				
				
				it "should display error message if user enters a invalid youtube url" do
						post "video_validator", {:yt_url => "http://google.com"}
						response.should be_success
						assigns(:status).should == false
						assigns(:message).should == "Invalid youtube url"
				end
				
				it "should display error message if user enters a valid youtube url format but with invalid video code" do
						post "video_validator", {:yt_url => "http://www.youtube.com/watch?v=urM7FO3whqAINV&feature=g-logo-xit"}
						response.should be_success
						assigns(:status).should == false
						assigns(:message).should == "Video not found"
				end				
		end		
end