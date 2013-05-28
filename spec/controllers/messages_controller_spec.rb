require 'spec_helper'

describe MessagesController do
  describe "POST 'receive_callback'" do
    FakeWeb.register_uri(:post, "http://wezolo-twillio.herokuapp.com/send_message", :body => "Message Sent", :status => 200)
    let!(:wezolo_sam) { create(:user, :phone_number => "+18082183629")}
    let(:params) { {"AccountSid"=>"AC8a06c3113311d16af3e84c54054b77b3", 
                    "Body"=>"Callback in rails ", 
                    "ToZip"=>"80204", "FromState"=>"HI", 
                    "ToCity"=>"DENVER", 
                    "SmsSid"=>"SM969bcccde41d8269fd94d87460af396c", 
                    "ToState"=>"CO", 
                    "To"=>"+17202599396", 
                    "ToCountry"=>"US", 
                    "FromCountry"=>"US", 
                    "SmsMessageSid"=>"SM969bcccde41d8269fd94d87460af396c", "ApiVersion"=>"2010-04-01", "FromCity"=>"HONOLULU", 
                    "SmsStatus"=>"received", 
                    "From"=>"+18082183629", 
                    "FromZip"=>"96857"} }
    let(:invalid_phone_number) { "+123" }
    it "receives message with unrecognised number and send message to inform the sender to register their number" do
      params["From"] = invalid_phone_number
      post 'receive_callback', params
      request = FakeWeb.last_request 
      FakeWeb.last_request.body.should eq("to=%2B123&body=Your+phone+number+does+not+seem+to+be+on+our+system.+Please+register+your+number+at+www.wezolo.com")
    end

    it "receives message with recognised number and save the incoming message" do
      post 'receive_callback', params
      Incoming.last.message.should eq("Callback in rails ")
      response.should be_success
    end
  end
end
# receive_callback
