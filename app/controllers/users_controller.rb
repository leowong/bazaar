class UsersController < ApplicationController
  def index
    if params[:q] && !params[:q].empty?
      @search = User.username_or_store_name_like_all(params[:q].to_s.split)
      @users = @search.all
    else
      @users = User.all
    end
  end
  
  def show
    @user  = User.find_by_username(params[:username])
  end
end
