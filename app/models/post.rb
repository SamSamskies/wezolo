class Post < ActiveRecord::Base
  belongs_to :blog
  attr_accessible :body, :published_at, :title
end
