class Country < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :users
  has_many :follows, :as => :followable
  has_many :followers, :through => :follows
  validates :name, :uniqueness => true
end
