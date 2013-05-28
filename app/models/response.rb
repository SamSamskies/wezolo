class Response < Message
  belongs_to :parent, :class_name => "Incoming", :foreign_key => "parent_id"
  attr_accessible :message, :parent_id, :user_id
  #validate parent_id exists
end
