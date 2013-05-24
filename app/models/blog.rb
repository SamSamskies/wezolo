class Blog < ActiveRecord::Base
  has_many :posts
  belongs_to :blog_host
  belongs_to :user
  attr_accessible :title, :url, :external_id
end
