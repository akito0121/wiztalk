class HomeController < ApplicationController
  
  def index
    @posts = Post.all.order(created_at: :desc)
    @new_tag = Tag.new
    @new_active = "active"
    @home = true
  end
  
  def like
    @posts = Post.all.order(lcount: :desc)
    @new_tag = Tag.new
    @like_active = "active"
    @home = true
    render("home/index")
  end
  
end
