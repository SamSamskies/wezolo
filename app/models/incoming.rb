class Incoming < Message
  has_many :responses, :class_name => "Response", :foreign_key => "parent_id"
  attr_accessible :message, :status, :user

  before_create :initialize_status
  
  def initialize_status
    self.status = "open"
  end
end
