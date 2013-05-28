class BlogsController < ApplicationController

  def create
    blog = Blog.create(params[:blog])
    blog.blog_host = BlogHost.find_or_create_by_name(params["blog_host"]["name"])
    blog.save
    current_user.blogs << blog
    redirect_to user_path(current_user)
  end
end
