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

  def display_blog_section(blog_host)
    if blog_connected?(blog_host)
      blog = blog(blog_host)

      if h.current_user == self
        h.link_to "Disconnect #{blog.title}", "/#{blog_host}/disconnect"
      else
        h.link_to blog.url, blog.url
      end
    else
      if h.current_user == self
        h.link_to "Connect your blog", "/auth/#{blog_host}"
      else
        "Not connected"
      end
    end
  end

  def blog_connected?(blog_host)
    self.blogs.map(&:blog_host).map(&:name).include?(blog_host)
  end

  def blog(blog_host)
    blog_host_id = BlogHost.find_by_name(blog_host).id
    self.blogs.where(:blog_host_id => blog_host_id).first
  end
end
