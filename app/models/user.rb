class User < ActiveRecord::Base
  
  STATUSES_HASH = {"interested" => "Interested in Peace Corps","ipcv" => "Invited Peace Corps Volunteer","pcv" => "Current Peace Corps Volunteer","rpcv" => "Returned Peace Corps Volunteer"}

  include Tire::Model::Search
  include Tire::Model::Callbacks
  index_name "#{Tire::Model::Search.index_prefix}users"

  has_secure_password

  attr_accessible :name, :password_digest, :status, :email, :password, :password_confirmation, :follower, :profile, :auth_status, :phone_number

  has_many :involvements
  has_many :countries, :through => :involvements

  accepts_nested_attributes_for :countries

  validates :email, :uniqueness => true

  has_many :blogs
  has_many :posts, :through => :blogs

  has_many :follows, :as => :followable, :dependent => :destroy
  has_many :followers, :through => :follows

  has_many :followings, :class_name => "Follow", :foreign_key => "follower_id", :dependent => :destroy
  has_many :heroes, :through => :followings, :source => :followable, :source_type => "User"

  has_many :following_countries, :through => :followings, :source => :followable, :source_type => "Country"

  has_many :authorizations
  has_many :auth_providers, :through => :authorizations

  has_one :profile

  has_many :messages
  has_many :incomings
  has_many :responses

  after_create :initialize_auth_status

  def self.statuses_hash
    STATUSES_HASH
  end

  AUTH_STATUSES = %w[guest incomplete user admin]

  AUTH_STATUSES.each do |auth_status|
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

  def self.search(search_query)
    tire.search(:load => true) do
      size 100
      query { string search_query, default_operator: "AND" } if search_query.present?
    end
  end

  def to_indexed_json
    to_json(methods: [:country_names, :user_bio, :user_location, :user_involvement_descriptions, :user_involvement_sectors])
  end

  def country_names
    # REVIEW: I'm pretty sure the associations (involvements, countries, etc) should default to an empty
    # array if there aren't any associations. So these .present? checks are probably unncessary.
    #
    # Also, all these methods that check for .present? will retun nil if .present? returns false. That
    # nil can pollute things downstream (you'd have to check for nil), so it's better to always return a
    # 'safe' return value, like an empty array.
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
    # REVIEW: 
    sort_by_published_date(self.heroes.includes(:posts).map(&:posts))
  end

  # method being deprecated
  def countries_posts
    sort_by_published_date(self.following_countries.includes(:posts).map(&:posts))
  end

  def user_followings_by_type
    # REVIEW: Checkout Enumberable#group_by: http://ruby-doc.org/core-2.0/Enumerable.html#method-i-group_by
    # self.followings.group_by{|following| following.followable_type}
    #
    self.followings.inject({}) do |follow_hash, following|
      type = following.followable_type
      id = following.followable_id
      follow_hash[type] ? follow_hash[type] << id : follow_hash[type] = [id]
      follow_hash
    end
  end

  # REVIEW: It's preferable to put class methods together, at the top of file (after associations & validations)
  def self.create_with_omniauth(auth)
    # Nice use of a block here for a complicated create
    new_user = create! do |user|
      provider = set_provider(auth)
      user.authorizations << provider.authorizations.create(uid: auth["uid"])
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.password = SecureRandom.hex(10)
    end
    new_user.create_profile(photo_url: auth["info"]["image"])
  end

  def initialize_auth_status
    self.update_attributes(:auth_status => "user") if self.status == ["interested"]
  end

  private

  def sort_by_published_date(array)
    array.flatten.sort_by {|post| post.published_at}.reverse
  end

  def self.phone_number(user_id)
    User.find(user_id).phone_number
  end
end
