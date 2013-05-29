class Authorization < ActiveRecord::Base
  extend ExternalAuth
  belongs_to :user
  belongs_to :auth_provider
  attr_accessible :uid, :token, :secret

  def self.find_or_create_by_uid(auth, user)
    provider = set_provider(auth)
    Authorization.find_by_uid(auth["uid"]) || Authorization.create(user: user, auth_provider: provider)
  end
end
