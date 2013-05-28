class Incoming < Message
  has_many :children, :class_name => "Response", :foreign_key => "parent_id"
  attr_accessible :message, :status

  before_create :initialize_status
  
  def initialize_status
    self.status = "open"
  end
end
