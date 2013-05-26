class UserDecorator < Draper::Decorator
  delegate_all

  def follow_link(followable_obj)
    if !self.nil? && self.user_followings_by_type[class_string(followable_obj)] && self.user_followings_by_type[class_string(followable_obj)].include?(followable_obj.id)
      h.link_to "Unfollow #{class_string(followable_obj)}", follows_path(followable_obj), :method => :delete
    else
      h.link_to "Follow #{class_string(followable_obj)}", follows_path(followable_obj), :method => :post
    end
  end

  def photo
    "http://agarwal.seas.upenn.edu/wp-content/uploads/2011/01/person_default_208x208-1.png"
  end

  def follows_path(followable_obj)
    h.follows_path(:followable_id => followable_obj.id, :followable_type => class_string(followable_obj))
  end

  def class_string(followable_obj)
    followable_obj.class.to_s
  end

end
