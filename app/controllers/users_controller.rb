class UsersController < ApplicationController
  def index
    if params[:q] && !params[:q].empty?
      @search = User.with_role(:seller).username_or_abbreviation_or_store_name_or_description_like_all(params[:q].to_s.split)
    else
      @search = User.with_role(:seller)
    end
    @users_count = @search.size
    @users = @search.paginate :page => params[:page], :per_page => 10 
  end
  
  def show
    @user  = User.find_by_username(params[:username])
  end
end
