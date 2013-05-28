require 'spec_helper'

describe Message do
  FakeWeb.register_uri(:post, "http://wezolo-twillio.herokuapp.com/send_message", :body => "Message Sent", :status => 200)
  context "#self.send_message" do
    it "message can be sent to the correct api host and callback uri" do
      response = Message.send_message({:to => "+123456789", :body => "Wezolo Sam, you so sexy"})
      response.body.should eq("Message Sent")
      response.status.should eq(200)
    end
  end

  context "#self.send_save_message in the incoming model" do
  let!(:wezolo_sam) { create(:user, name: "wezolo_sam")}
  let!(:incoming) { create(:incoming, :user => wezolo_sam) }
  it "sends message and if status is 200 saves the message" do
    saved_message = Response.send_and_save_message({:incoming_id => 1, message: "Wezolo Sam, you so sexy", response_user_id: 1}, 
                                   {:to => "+123456789", :body => "Wezolo Sam, you so sexy"})
    saved_message.should eq(Response.first)
  end
end
end
