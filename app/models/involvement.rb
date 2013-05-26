class Involvement < ActiveRecord::Base
  belongs_to :user
  belongs_to :country
  attr_accessible :sector, :description, :start_date, :end_date
end
