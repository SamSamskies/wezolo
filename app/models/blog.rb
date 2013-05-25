class Blog < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
  has_many :posts, :dependent => :destroy
  belongs_to :blog_host
  belongs_to :user
  attr_accessible :title, :url, :external_id, :user_id
  validates :url, :uniqueness => true
end
