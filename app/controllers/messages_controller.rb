class MessagesController < ApplicationController
  def index
    @messages = Message.includes(:user).all
    @incomings = Incoming.all
  end

  def create
    response = Response.send_and_save_message(params,
     {:to => User.phone_number(params[:incoming_user_id]),
      :body => params[:message]})
    redirect_to messages_path, :notice => response
  end

  def receive_callback
    if user = User.find_by_phone_number(params["From"])
      Incoming.create(message: params["Body"], user: user)
    else
      Message.send_message({:to => params["From"],
        :body => "Your phone number does not seem to be on our system. Please register your number at www.wezolo.com"})
    end
    render :nothing => true, :status => :ok
  end

end

# params
# "incoming_user_id"=>"715", "response_user_id"=>"714", "incoming_id"=>"16", "message"=>"fda", "commit"=>"send", "action"=>"create", "controller"=>"messages"
  # USER_NOT_FOUND_MSG = "Your number does not seem to be on our system. Please register an your number at www.wezolo.com!"
  # VERIFY_PHONE_NUM_MSG = "Please enter the following code into the registration website: #{SecureRandom.hex(2)}"
