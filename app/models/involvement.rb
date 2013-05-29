class Involvement < ActiveRecord::Base
  belongs_to :user
  belongs_to :country
  attr_accessible :sector, :description, :start_date, :end_date, :country_id
  
  validate :valid_sector?

  after_create :update_auth_status
  after_save  :update_user_search_index

  SECTORS = ['ict', 'business', 'education', 'health', 'community development', 'environment', 'youth development', 'agriculture', 'other']

  def valid_sector?
    errors.add(:sector, "is not valid!") unless SECTORS.include?(sector)
  end
  # refactor required
  def update_auth_status
    self.user.update_attributes(:auth_status => "user") if self.user.auth_status == "incomplete"
  end

  def update_user_search_index
    user.update_index
  end

  def self.sectors
    SECTORS
  end
end
