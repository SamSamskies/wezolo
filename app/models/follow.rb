class Follow < ActiveRecord::Base
  belongs_to :follower, :class_name => "User"
  belongs_to :followable, :polymorphic => true
  attr_accessible :followable_id, :followable_type, :follower_id, :follower
  # validates_uniqueness_of :follower_id, :scope => [:followable_id, :followable_type]
end
