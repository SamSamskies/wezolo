module ExternalAuth
  def set_provider(auth)
    AuthProvider.find_by_name(auth["provider"])
  end
end
