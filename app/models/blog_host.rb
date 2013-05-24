class BlogHost < ActiveRecord::Base
  has_many :blogs
  attr_accessible :name
end
