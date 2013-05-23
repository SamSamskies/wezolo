class User < ActiveRecord::Base
  attr_accessible :avatar_url, :name, :password_digest, :sector, :status, :username, :email, :country
  has_and_belongs_to_many :countries
end
