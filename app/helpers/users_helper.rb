module UsersHelper
  def render_user_box(user)
    render :partial => "users/user", :locals => {:user => user}
  end
end
