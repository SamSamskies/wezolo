class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :avatar_url, :name, :password_digest, :sector, :status, :username, :email, :country, :password, :password_confirmation, :countries_attributes
  has_and_belongs_to_many :countries
  accepts_nested_attributes_for :countries
  validates :email, :uniqueness => true
  validates :username, :uniqueness => true
end
