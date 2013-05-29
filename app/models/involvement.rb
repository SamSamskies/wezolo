class Involvement < ActiveRecord::Base
  belongs_to :user
  belongs_to :country
  attr_accessible :sector, :description, :start_date, :end_date, :country_id
  
  validate :valid_sector?
  validate :valid_dates?

  after_create :update_auth_status
  after_save  :update_user_search_index
  before_validation :downcase_sector
  
  SECTORS = ['ict', 'business', 'education', 'health', 'community development', 'environment', 'youth development', 'agriculture', 'other']

  def valid_sector?
    errors.add(:sector, "is not valid!") unless SECTORS.include?(sector)
  end

  def valid_dates?
    errors.add(:end_date, "can not be before start date!") if start_date > end_date
  end

  def downcase_sector
    self.sector = self.sector.downcase
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
