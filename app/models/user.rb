class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :avatar_url, :name, :password_digest, :sector, :status, :username, :email, :country, :password, :password_confirmation, :countries_attributes, :follower
  has_and_belongs_to_many :countries
  accepts_nested_attributes_for :countries
  has_many :follows, :as => :followable
  has_many :followers, :through => :follows

  has_many :followings, :class_name => "Follow", :foreign_key => "follower_id"
  has_many :celebs, :through => :followings, :source => :followable, :source_type => "User"
  has_many :following_countries, :through => :followings, :source => :followable, :source_type => "Country"
  validates :email, :uniqueness => true
  validates :username, :uniqueness => true
end

# justin = User.find(29)
# fan = User.find(30)


 #  User Load (0.8ms)  SELECT "users".* FROM "users" INNER JOIN "follows" ON "users"."id" = "follows"."followable_id" WHERE "follows"."followable_id" = 30 AND "follows"."followable_type" = 'User' AND "follows"."followable_type" = 'User'
 # => []


# SELECT "users".* FROM "users" 
# INNER JOIN "follows" 
# ON "users"."id" = "follows"."followable_id" 
# WHERE "follows"."followable_id" = 30 AND "follows"."followable_type" = 'User' AND "follows"."followable_type" = 'User


# SELECT "users".* FROM "users" INNER JOIN "follows" ON "users"."id" = "follows"."follower_id" 
# WHERE "follows"."followable_id" = 30 AND "follows"."followable_type" = 'User'
# SELECT "users".* FROM "users" INNER JOIN "follows" ON "users"."id" = "follows"."follower_id" WHERE "follows"."follower_id" = 30
