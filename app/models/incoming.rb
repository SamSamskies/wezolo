class Incoming < ActiveRecord::Base
  belongs_to :user
  attr_accessible :message, :status
end
