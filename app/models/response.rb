class Response < Message
  belongs_to :parent, :class_name => "Incoming", :foreign_key => "parent_id"
  attr_accessible :message, :parent_id, :user_id
  validates :message, :presence => true
  
  # REVIEW: Knowing the content of success/failure message shouldn't be a responsiblity 
  # of this class. This method should return the new message object or nil depending on
  # whether the message was saved. 
  def self.send_and_save_message(params, message_options)
    if self.send_message(message_options)
      message = self.save_message(params)
      message.errors.present? ? message.errors.full_messages.join(', ') : "Message sent"
    else
      "Something went wrong"
    end
  end

  def self.save_message(params)
    self.create(message: params[:message], user_id: params[:response_user_id], parent_id: params[:incoming_id])
  end
end
