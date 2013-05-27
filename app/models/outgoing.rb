class Outgoing < ActiveRecord::Base
  belongs_to :user
  belongs_to :incoming
  attr_accessible :message, :user
end
