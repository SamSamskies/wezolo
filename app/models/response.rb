class Response < Message
  belongs_to :parent, :class_name => "Incoming", :foreign_key => "parent_id"
  attr_accessible :message, :parent_id, :user_id
  #validate parent_id exists
  def self.send_and_save_message(params, message_options)
    response = Message.send_message(message_options)
    Response.save_message(params) if response.status == 200
  end

  def self.save_message(params)
    incoming = Incoming.where(id: params[:incoming_id]).first
    incoming.responses.create(message: params[:message], user_id: params[:response_user_id])
  end
end
