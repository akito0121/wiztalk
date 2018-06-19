class LikeController < ApplicationController

    before_action :login_to_like
    
    def login_to_like
        if @current_user == nil
            flash[:notice] = "「いいね！」するには登録が必要"
            redirect_to("/post/#{params[:id]}")
        end
    end

    def create
        @like = Like.new(user_id: @current_user.id,post_id: params[:id])
        @like.save
        @post = Post.find_by(id: params[:id])
        @post.lcount = @post.like_count
        @post.save
        redirect_to("/post/#{params[:id]}")
    end
    
    def destroy
        @like = Like.find_by(user_id: @current_user.id,post_id: params[:id])
        @like.destroy
        @post = Post.find_by(id: params[:id])
        @post.lcount = @post.like_count
        @post.save
        redirect_to("/post/#{params[:id]}")
    end
    
    
end
