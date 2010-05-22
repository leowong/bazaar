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

  def account
    @user = current_user
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Registration successful."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    unless params[:id] == "current"
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end
  
  def update
    unless params[:id] == "current"
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile."
      redirect_to store_path(@user.username)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Successfully destroyed user."
    redirect_to users_url
  end
end
