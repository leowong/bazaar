class Admin::UsersController < Admin::BaseController
  def index
    if params[:q] && !params[:q].empty?
      @search = User.username_or_store_name_like_all(params[:q].to_s.split)
      @users = @search.descend_by_created_at
    else
      @users = User.descend_by_created_at
    end
  end
  
  def show
    unless params[:id] == "current"
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    puts params
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Registration successful."
      redirect_to admin_users_url
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
      redirect_to admin_user_path("current")
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Successfully destroyed user."
    redirect_to admin_users_url
  end
end
