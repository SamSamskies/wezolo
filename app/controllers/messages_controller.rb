class MessagesController < ApplicationController
  def index
    @messages = Message.includes(:user).all
    @incomings = Incoming.all
  end

  def create
    sending_message_to = User.find(params[:incoming_user_id]).phone_number
    conn = Faraday.new(:url => 'http://wezolo-twillio.herokuapp.com/') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    response = conn.post '/send_message', {:to => sending_message_to, :body => params[:message]}
    message = save_message(params) if response.status == 200
    redirect_to messages_path
  end

  def receive_callback
    user = User.find_by_phone_number(params["From"])
    body = params["Body"]
    Incoming.create(message: body, user: user)
    render :nothing => true, :status => :ok
  end

  def save_message(params)
    incoming = Incoming.where(id: params[:incoming_id]).first
    incoming.responses.create(message: params[:message], user_id: params[:response_user_id])
  end
end




# "incoming_user_id"=>"715", "response_user_id"=>"714", "incoming_id"=>"16", "message"=>"fda", "commit"=>"send", "action"=>"create", "controller"=>"messages"
  # USER_NOT_FOUND_MSG = "Your number does not seem to be on our system. Please register an your number at www.wezolo.com!"
  # VERIFY_PHONE_NUM_MSG = "Please enter the following code into the registration website: #{SecureRandom.hex(2)}"


# {"AccountSid"=>"AC8a06c3113311d16af3e84c54054b77b3", 
#   "Body"=>"Callback in rails ", 
#   "ToZip"=>"80204", "FromState"=>"HI", 
#   "ToCity"=>"DENVER", 
#   "SmsSid"=>"SM969bcccde41d8269fd94d87460af396c", 
#   "ToState"=>"CO", 
#   "To"=>"+17202599396", 
#   "ToCountry"=>"US", 
#   "FromCountry"=>"US", 
#   "SmsMessageSid"=>"SM969bcccde41d8269fd94d87460af396c", "ApiVersion"=>"2010-04-01", "FromCity"=>"HONOLULU", 
#   "SmsStatus"=>"received", 
#   "From"=>"+18082183629", 
#   "FromZip"=>"96857"}
