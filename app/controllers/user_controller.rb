class UserController < ApplicationController
  
  before_action :need_login, {only: [:index,:like]}
    
    
    
  def regist
    
  end
  
  def index
    @posts = Post.where(user_id: @current_user.id)
    render("home/index")
  end
  
  def like
    @likes = Like.where(user_id: @current_user.id)
  end
  
  def create
    @user = User.new(name: params[:name],password: params[:password], sex: params[:sex])
    if @user.save
      session[:user] = @user.id
      redirect_to("/")
    else
      render("user/regist")
    end
  end
  
  def login
    @user = User.find_by(name: params[:name],password: params[:password])
    if @user
      session[:user] = @user.id
      redirect_to("/")
    else
      @login_error = "ログインできません。"
      @wrong_name = params[:name]
      @wrong_pass = params[:password]
      render("user/new")
    end
  end
  
  def logout
    session[:user] = nil
    redirect_to("/")
  end

end
