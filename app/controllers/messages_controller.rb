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

  # Review: This is method is to receive messages from Twillio, right? Messages sent via txt to a particular
  # user? It's not clear what's going on from the action name or code. Consider renaming things and/or adding
  # comments.
  def receive_callback
    if user = User.find_by_phone_number(params["From"])
      Incoming.create(message: params["Body"], user: user)
    else
      Message.send_message({:to => params["From"],
        :body => "Your number does not seem to be on our system. Please register an your number at www.wezolo.com"})
    end
    render :nothing => true, :status => :ok
  end

end
