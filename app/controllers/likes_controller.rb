class LikesController < ApplicationController
  def new
    @like = Like.new
    respond_to do |format|
      format.html { render :new, locals: { like: @like } }
    end
  end

  def create
    @like = Like.new
    @post = Post.find(params[:post_id])
    @user = current_user
    @like.author = current_user
    @like.post = @post
    respond_to do |format|
      format.html do
        if @like.save
          flash[:success] = 'Like saved successfully'
          redirect_to user_post_path(current_user, @post)
        else
          flash.now[:error] = 'Error: Like could not be saved'
          render :new
        end
      end
    end
  end
end
