class User < ActiveRecord::Base  
  # include Tire::Model::Search
  # include Tire::Model::Callbacks
  has_secure_password
  attr_accessible :avatar_url, :name, :password_digest, :sector, :status, :username, :email, :country, :password, :password_confirmation, :countries_attributes, :follower
  has_and_belongs_to_many :countries
  accepts_nested_attributes_for :countries
  
  validates :email, :uniqueness => true
  validates :username, :uniqueness => true

  has_many :blogs
  has_many :posts, :through => :blogs

  #find all the followers(user as named) a user is following
  has_many :follows, :as => :followable, :dependent => :destroy
  has_many :followers, :through => :follows

  #find all the users(use .heroes) a user is following
  has_many :followings, :class_name => "Follow", :foreign_key => "follower_id", :dependent => :destroy
  has_many :heroes, :through => :followings, :source => :followable, :source_type => "User"

  #find all the countries(user .following_countries) a user is following
  has_many :following_countries, :through => :followings, :source => :followable, :source_type => "Country"


  has_many :authorizations
  has_many :auth_providers, :through => :authorizations

  def followed_posts
    (self.heroes_posts + self.countries_posts).uniq
  end

  def heroes_posts
    sort_by_published_date(self.heroes.includes(:posts).map(&:posts))
  end

  def countries_posts
    sort_by_published_date(self.countries.includes(:posts).map(&:posts))
  end

  #refactor later
  def sort_by_published_date(array)
    array.flatten.sort_by {|post| post.published_at}.reverse
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      provider = AuthProvider.find_by_name(auth["provider"]) #refactor since repeated
      user.authorizations << provider.authorizations.create(uid: auth["uid"])
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.username = auth["info"]["email"]
      user.password = SecureRandom.hex(10)
    end
  end

end
