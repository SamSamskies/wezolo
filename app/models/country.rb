class Country < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :users
  validates :name, :uniqueness => true
end
