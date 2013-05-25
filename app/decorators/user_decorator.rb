class UserDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def follow_link(followable_obj)
    if h.current_user && h.current_user.user_followings_by_type[followable_obj.class.to_s].include?(followable_obj.id)
      h.link_to "unfollow #{followable_obj.class.to_s.downcase}", h.follows_path(:followable_id => followable_obj.id, :followable_type => followable_obj.class.to_s), :method => :delete
    else
      h.link_to "follow #{followable_obj.class.to_s.downcase}", h.follows_path(:followable_id => followable_obj.id, :followable_type => followable_obj.class.to_s), :method => :post
    end
  end
end

  #   - if current_user && current_user.user_followings_by_type["User"].include?(user.id)
  #     %li= link_to "unfollow user", follows_path(:followable_id => user.id, :followable_type => user.class.to_s), :method => :delete
  #   - else
  #     %li= link_to "follow user", follows_path(:followable_id => user.id, :followable_type => user.class.to_s), :method => :post
  # def downvote_button
  #   if h.current_user.nil? || h.user_votes[object.id] != "down"
  #     vote_button("Downvote", {:id => "down#{object.id}", :value => "down", :class => "btn vote"})
  #   else
  #     vote_button("Downvote", {:id => "no_down#{object.id}", :value => "no_down", :class => "btn vote btn-success"})
  #   end
  # end
