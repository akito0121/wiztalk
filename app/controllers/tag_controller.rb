class TagController < ApplicationController
  
  def new_tag
    if @current_user
      @new_tag = Tag.new(name: params[:new_tag])
      @post = Post.new
      if @new_tag.save
          redirect_to("/")
      else
        @posts = Post.all.order(created_at: :desc)
        render("home/index")
      end
    else
      flash[:notice] = "登録が必要です"
      redirect_to("/user/regist")
    end
  end
  
  def index
    @tag_name = params[:tag]
    @categorys = Category.where(name: params[:tag])# .pluck(:post_id)
  end
  
  
end