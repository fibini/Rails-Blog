class Api::V1::CommentsController < ApplicationController
  def index
    @users = User.find(params[:user_id])
    @posts = @users.posts
    @comments = Comment.includes(:author).where(post: @posts)

    render json: @comments
  end
end
