class User < ActiveRecord::Base
  extend ExternalAuth
  include Tire::Model::Search
  include Tire::Model::Callbacks
  index_name "#{Tire::Model::Search.index_prefix}users"

  STATUSES_HASH = {"interested" => "Interested in Peace Corps","ipcv" => "Invited Peace Corps Volunteer","pcv" => "Current Peace Corps Volunteer","rpcv" => "Returned Peace Corps Volunteer"}

  has_secure_password

  attr_accessible :name, :password_digest, :status, :email, :password, :password_confirmation, :follower, :profile, :auth_status, :phone_number

  has_many :involvements
  has_many :countries, :through => :involvements

  accepts_nested_attributes_for :countries

  validates :email, :uniqueness => true
  validate :valid_status?
  before_validation :downcase_status
  before_save :follow_sam

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

  def valid_status?
    errors.add(:status, "is not valid!") unless STATUSES_HASH[status]
  end

  def downcase_status
    self.status = self.status.downcase
  end

  def follow_sam
    self.heroes << User.find_by_email("samprofessional@gmail.com")
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

  def change_password(user)
    if self.authenticate(user[:current_password])
      self.update_attributes(:password => user["password"], :password_confirmation => user["password_confirmation"])
    else 
      self.errors.add(:What?, "Authentication of Current Password Failed")
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

  def followed_posts(pagination = {})
    self.heroes_posts.paginate(:page => pagination[:page], :per_page => pagination[:per_page])
     # + self.countries_posts
  end

  def heroes_posts
      Post.includes({:blog => :user}).joins({:blog => {:user => :follows}}).where("follows.follower_id" => self.id).order("published_at DESC")
  end

  # method being deprecated
  def countries_posts
    # Post.joins({:blog => {:user => :follows}}).where("follows.follower_id" => self.id).order("published_at DESC")
    # sort_by_published_date(self.following_countries.includes(:posts).map(&:posts))
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
    new_user = create! do |user|
      provider = set_provider(auth)
      user.authorizations << provider.authorizations.create(uid: auth["uid"])
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.password = SecureRandom.hex(10)
    end
    new_user.create_profile(photo_url: auth["info"]["image"])
    new_user
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
