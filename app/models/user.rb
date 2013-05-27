class User < ActiveRecord::Base  
  include Tire::Model::Search
  include Tire::Model::Callbacks

  has_secure_password

  attr_accessible :name, :password_digest, :status, :email, :password, :password_confirmation, :follower, :profile, :auth_status

  # validates :status, :presence => true

  has_many :involvements
  has_many :countries, :through => :involvements

  accepts_nested_attributes_for :countries
  
  validates :email, :uniqueness => true

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

  has_one :profile

  after_create :initialize_auth_status
  # before_create :initialize_user_profile

  AUTH_STATUSES = %w[incomplete user admin]

  AUTH_STATUSES.each do |auth_status|
    #ability inheritance
    define_method "#{auth_status}_auth?" do
      AUTH_STATUSES.index(self.auth_status) <= AUTH_STATUSES.index(auth_status)
    end

    define_method "#{auth_status}?" do
      self.auth_status == auth_status
    end

  end


  tire do
    mapping do
      indexes :id,          :index => :not_analyzed
      indexes :name,        :boost => 100
      indexes :username
      indexes :status
      indexes :country_names
      indexes :user_bio
      indexes :user_location
      indexes :user_involvement_descriptions
      indexes :user_involvement_sectors
    end
  end

  def self.search(params)
    tire.search(:load => true) do
      size 100
      query { string params[:search], default_operator: "AND" } if params[:search].present?
      # filter :range, published_at: {lte: Time.zone.now}
    end
  end

  def to_indexed_json
    to_json(methods: [:country_names, :user_bio, :user_location, :user_involvement_descriptions, :user_involvement_sectors])
  end

  def country_names
    countries.map(&:name) if self.countries.present?
  end

  def user_bio
    profile.bio if self.profile.present?
  end

  def user_location
    profile.location if self.profile.present?
  end

  def user_involvement_descriptions
    involvements.map(&:description) if self.involvements.present?
  end

  def user_involvement_sectors
    involvements.map(&:sector) if self.involvements.present?
  end

  def followed_posts
    (self.heroes_posts + self.countries_posts).uniq
  end

  def heroes_posts
    sort_by_published_date(self.heroes.includes(:posts).map(&:posts))
  end

  def countries_posts
    sort_by_published_date(self.following_countries.includes(:posts).map(&:posts))
  end



  def user_followings_by_type
    self.followings.inject({}) do |follow_hash, following|
      type = following.followable_type
      id = following.followable_id
      follow_hash[type] ? follow_hash[type] << id : follow_hash[type] = [id]
      follow_hash
    end
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      provider = AuthProvider.find_by_name(auth["provider"]) #refactor since repeated
      user.authorizations << provider.authorizations.create(uid: auth["uid"])
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.password = SecureRandom.hex(10)
      user.create_profile(photo_url: auth["info"]["image"])
    end
  end


  def initialize_auth_status
    self.update_attributes(:auth_status => "user") if self.status == ["interested"]
  end

  # def initialize_user_profile
  #   create_profile
  # end

  private
  def sort_by_published_date(array)
    array.flatten.sort_by {|post| post.published_at}.reverse
  end
end
