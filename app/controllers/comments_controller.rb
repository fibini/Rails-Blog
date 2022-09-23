class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    respond_to do |format|
      format.html { render :new, locals: { comment: @comment } }
    end
  end

  def create
    @comment = Comment.new(params.require(:comment).permit(:post_id, :text))
    @post = Post.find(params[:post_id])
    @user = current_user
    @comment.author = current_user
    @comment.post = @post
    respond_to do |format|
      format.html do
        if @comment.save
          flash[:success] = 'Comment saved successfully'
          redirect_to user_post_path(current_user, @post)
        else
          flash.now[:error] = 'Error: Comment could not be saved'
          render :new
        end
      end
    end
  end
end
