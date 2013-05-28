class Blog < ActiveRecord::Base
  has_many :posts, :dependent => :destroy
  belongs_to :blog_host
  belongs_to :user
  attr_accessible :title, :url, :external_id, :user_id
  validates :url, :uniqueness => true
  # after_save :import_tumblr_posts

  # def import_tumblr_post
  #   Tumblr.configure do |config|
  #     config.oauth_token = self.user.authorizations.where("auth_provider_id" = "5")
  #     config.oauth_token_secret = auth["credentials"]["secret"]
  #   end

  #   client = Tumblr::Client.new
  #   posts = client.posts(self.url)
  #   p posts
  # end
end
