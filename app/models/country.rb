class Country < ActiveRecord::Base
  # include Tire::Model::Search
  # include Tire::Model::Callbacks
  attr_accessible :name, :post, :blogs, :users
  
  has_many :involvements
  has_many :users, :through => :involvements
  has_many :blogs, :through => :users
  has_many :posts, :through => :blogs

  has_many :follows, :as => :followable
  has_many :followers, :through => :follows
  validates :name, :uniqueness => true
end
