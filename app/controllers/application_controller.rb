class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action:set_user,:tag_count
  
  def set_user
    @current_user = User.find_by(id: session[:user])
    @tags = Tag.all.order(post_count: :desc)
    @user = User.new
  end
  
  def need_login
    if @current_user == nil
      flash[:notice] = "ログインしてください"
      redirect_to("/")
    end
  end
  
  def tag_count
    @tagcounts = Tag.all
      @tagcounts.each do |tag|
      tag.post_count = tag.count
      tag.save
    end
  end
  
end
