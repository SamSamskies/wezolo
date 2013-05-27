class Involvement < ActiveRecord::Base
  belongs_to :user
  belongs_to :country
  attr_accessible :sector, :description, :start_date, :end_date, :country_id

  after_create :update_auth_status
  after_save  :update_user_search_index

  # refactor required
  def update_auth_status
    self.user.update_attributes(:auth_status => "user") if self.user.auth_status == "incomplete"
  end

  def update_user_search_index
    user.update_index
  end
end
