class Authorization < ActiveRecord::Base
  belongs_to :user
  belongs_to :auth_provider
  attr_accessible :uid
end
