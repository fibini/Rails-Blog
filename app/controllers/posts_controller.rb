class PostsController < ApplicationController
  def index
    @posts = 'Here is a list of posts for a given user'
  end

  def show
    @specific_post = 'This shows a specific post for a specific user'
  end
end
