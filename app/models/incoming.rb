class Incoming < ActiveRecord::Base
  belongs_to :user
  has_many :outgoings
  attr_accessible :message, :status
end
