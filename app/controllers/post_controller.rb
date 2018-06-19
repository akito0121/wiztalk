class PostController < ApplicationController
  
    before_action :login_to_new, {only: [:new,:create]}
    
    def login_to_new
      if @current_user == nil
        flash[:notice] = "投稿するには登録が必要です"
        redirect_to("/")
      end
    end  
    
  def new
    @post = Post.new
    @new_tag = Tag.new
    @tags = Tag.all
  end
  
  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.post_user
  # @user = User.find_by(id: @post.user_id)
    @like_count = Like.where(post_id: params[:id]).count
    @coms = Com.where(post_id: params[:id])
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
    @new_tag = Tag.new
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    @post.title = params[:title]
    @post.content = params[:content]
    if @post.save
      @tag_names = params[:tag_name]
      if @tag_names
        @tag_names.each do |tag_name|
          @category = Category.create(post_id: @post.id,name: tag_name)
        end
      end
      flash[:notice] = "編集しました"
      redirect_to("/")
    else
      render("post/edit")
    end
  end
  
  def create
    @post = Post.new(title: params[:title],content: params[:content],user_id: @current_user.id,lcount: 0)
    if @post.save
      if params[:image]
        @post.image = "#{@post.id}.jpg"
        @post.save
        pimage = params[:image]
        File.binwrite("public/post_images/#{@post.image}",pimage.read)
      end
      @tag_names = params[:tag_name]
      if @tag_names
        @tag_names.each do |tag_name|
          @category = Category.create(post_id: @post.id,name: tag_name)
        end
      end
      flash[:notice] ="投稿を作成しました"
      redirect_to("/")
    else
      render("post/new")
    end
  end
  
    
  
    def commentif
      if @current_user
        return @current_user.id
      else
        return 1
      end
    end  
  
  def contentif
    if params[:comment]
      return true
    elsif params[:image]
      return true
    else
      return nil
    end
  end
      
  
  def comment
    @comment = Com.new(user_id: commentif,post_id: params[:id],content: params[:comment],image: params[:image])
    if @comment.save
      if params[:image]
        @comment.image = "#{@comment.id}.jpg"
        @comment.save
        pimage = params[:image]
        File.binwrite("public/com_images/#{@comment.image}",pimage.read)
      end
      redirect_to("/post/#{params[:id]}/#end")
    else
      flash[:notice_comment] = "空の投稿はできません"
      redirect_to("/post/#{params[:id]}/#end")
    end
  end
  
end
