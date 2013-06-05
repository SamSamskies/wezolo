class AuthProvider < ActiveRecord::Base
  has_many :authorizations
  has_many :users, :through => :authorizations
  attr_accessible :name
end
