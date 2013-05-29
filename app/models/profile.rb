class Profile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :bio, :location, :major, :occupation, :photo_url, :sector, :status, :university, :username, :user_attributes
  accepts_nested_attributes_for :user, :allow_destroy => true
  
  after_save :update_user_search_index

  SECTORS = ["Education", "Health", "Community Economic Development", "Environment", "Youth in Development", "Agriculuture"]

  def update_user_search_index
    user.update_index
  end
end
