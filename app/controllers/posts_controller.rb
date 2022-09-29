class PostsController < ApplicationController
  def index
    @users = User.find(params[:user_id])
    @specific_user = User.find(params[:user_id])
    @posts = @users.posts
    # @specific_post = Post.find(params[:user_id])
  end

  def new
    @post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: @post } }
    end
  end

  def create
    # new object from params
    @post = Post.new(params.require(:post).permit(:title, :text))
    @post.author = current_user
    # respond_to block
    respond_to do |format|
      format.html do
        if @post.save
          # success message
          flash[:success] = 'Post saved successfully'
          # redirect to index
          redirect_to user_path(current_user)
        else
          # error message
          flash.now[:error] = 'Error: Post could not be saved'
          # render new
          render :new, new_user_post_path(current_user)
        end
      end
    end
  end

  def show
    @specific_post = Post.find(params[:id])
    @user = current_user
    @comments = Comment.includes(:author).where(post: @specific_post)
  end

  def destroy
    @specific_post = Post.find(params[:id])
    @specific_post.destroy
    flash[:notice] = 'Post removed succesfully!'
    redirect_to user_posts_path(current_user)
  end
end
