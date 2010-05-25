class UsersController < ApplicationController
  def index
    if params[:q] && !params[:q].empty?
      @search = User.with_role(:seller).username_or_store_name_like_all(params[:q].to_s.split)
      @users = @search.paginate :page => params[:page], :per_page => 10
    else
      @users = User.with_role(:seller).paginate :page => params[:page], :per_page => 10
    end
  end
  
  def show
    @user  = User.find_by_username(params[:username])
  end
end
