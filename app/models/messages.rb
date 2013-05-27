class Messages < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent, :class_name => "Message"
  has_many :children, :class_name => "Message", :foreign_key => "parent_id"
  attr_accessible :message, :msg_type, :status
end
