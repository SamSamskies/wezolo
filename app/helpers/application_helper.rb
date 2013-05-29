module ApplicationHelper  
  def avatar_url(user, size)
    if user.profile.photo_url.present?
      user.profile.photo_url
    else
      default_url = "#{root_url}images/avatar_default.png"
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=#{CGI.escape(default_url)}"
    end
  end
end
