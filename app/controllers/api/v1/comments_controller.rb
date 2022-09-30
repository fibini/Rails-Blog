class Api::V1::CommentsController < ApplicationController
  def index
    @users = User.find(params[:user_id])
    @posts = @users.posts
    @comments = Comment.includes(:author).where(post: @posts)

    render json: @comments
  end
  def create
    @comment = Comment.new(params.require(:comment).permit(:text).merge(post_id: params[:post_id], author_id: params[:user_id]))
    if @comment.save
        render json: @comment
      else
        render json: { errors: @comment.errors.full_messages }
    end
  end
end
