class Profile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :bio, :location, :major, :occupation, :photo_url, :sector, :status, :university, :username
end
