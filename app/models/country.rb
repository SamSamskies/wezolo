class Country < ActiveRecord::Base
  # include Tire::Model::Search
  # include Tire::Model::Callbacks
  attr_accessible :name
  
  has_many :involvements
  has_many :users, :through => :involvements
  has_many :blogs, :through => :users
  has_many :posts, :through => :blogs #, :condition => User.find(user_id).countries.

  has_many :follows, :as => :followable
  has_many :followers, :through => :follows
  validates :name, :uniqueness => true
end
