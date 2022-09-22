class PostsController < ApplicationController
  def index
    @users = User.find(params[:user_id])
    @specific_user = User.find(params[:user_id])
    @posts = @users.posts
    @specific_post = Post.find(params[:user_id])
  end

  def show
    @specific_post = Post.find(params[:id])
    @user = User.find(params[:user_id])
  end
end
