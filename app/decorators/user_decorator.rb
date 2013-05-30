class UserDecorator < Draper::Decorator
  delegate_all

  def follow_link(followable_obj)
    if !self.nil? && self.user_followings_by_type[class_string(followable_obj)] && self.user_followings_by_type[class_string(followable_obj)].include?(followable_obj.id)
      h.link_to "Unfollow #{class_string(followable_obj)}", follows_path(followable_obj), :method => :delete, :remote => true, :class => "follow-btn"
    else
      h.link_to "Follow #{class_string(followable_obj)}", follows_path(followable_obj), :method => :post, :remote => true, :class => "follow-btn"
    end
  end

  def photo
    "http://agarwal.seas.upenn.edu/wp-content/uploads/2011/01/person_default_208x208-1.png"
  end

  def follows_path(followable_obj)
    h.follows_path(:followable_id => followable_obj.id, :followable_type => class_string(followable_obj))
  end

  # refactoring required
  def unfollow_link_widget(params)
    h.link_to "Unfollow #{params[:followable_type]}", follows_path_by_params(params), :method => :delete, :remote => true, :class => "follow-btn"
  end

  # refactoring required
  def follow_link_widget(params)
    h.link_to "Follow #{params[:followable_type]}", follows_path_by_params(params), :method => :post, :remote => true, :class => "follow-btn"
  end

  # refactoring required
  def follows_path_by_params(params)
    h.follows_path(:followable_id => params[:followable_id], :followable_type => params[:followable_type])
  end

  def class_string(followable_obj)
    followable_obj.class.to_s
  end

  def blog_connect(blog_host)
    if blog_connected?(blog_host)
      if h.current_user == self
        href = "#"
        if blog_host == "tumblr"
          href = "/tumblr/disconnect"
        elsif blog_host == "blogger"
          href = "/blogger/disconnect"
        end
        h.link_to "Disconnect your blog", href
      else
        h.link_to "Blog URL", "#"
      end
    else
      if h.current_user == self
        if blog_host == "tumblr"
          authorize_url = "/auth/tumblr"
        elsif blog_host == "blogger"
          authorize_url = "/auth/blogger"
        end
        h.link_to "Connect your blog", authorize_url
      else
        "Not connected"
      end
    end
  end

  def blog_connected?(blog_host)
    self.blogs.map(&:blog_host).map(&:name).include?(blog_host)
  end

end
