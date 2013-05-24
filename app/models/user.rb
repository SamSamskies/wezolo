class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :avatar_url, :name, :password_digest, :sector, :status, :username, :email, :country, :password, :password_confirmation, :countries_attributes, :follower
  has_and_belongs_to_many :countries
  accepts_nested_attributes_for :countries
  
  validates :email, :uniqueness => true
  validates :username, :uniqueness => true


  #find all the followers(user as named) a user is following
  has_many :follows, :as => :followable
  has_many :followers, :through => :follows

  #find all the users(use .celebs) a user is following
  has_many :followings, :class_name => "Follow", :foreign_key => "follower_id"
  has_many :celebs, :through => :followings, :source => :followable, :source_type => "User"

  #find all the countries(user .following_countries) a user is following
  has_many :following_countries, :through => :followings, :source => :followable, :source_type => "Country"


end
