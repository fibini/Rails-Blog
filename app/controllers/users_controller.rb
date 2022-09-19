class UsersController < ApplicationController
  def index
    @users = 'This page shows all users'
  end

  def show
    @specific_user = 'This is a specific user'
  end
end
