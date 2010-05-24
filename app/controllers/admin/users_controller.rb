class Admin::UsersController < Admin::BaseController
  def index
    if params[:q] && !params[:q].empty?
      @search = User.username_or_store_name_like_all(params[:q].to_s.split)
      @users = @search.descend_by_created_at
    else
      @users = User.descend_by_created_at
    end
    authorize! :index, User
  end
  
  def show
    unless params[:id] == "current"
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    authorize! :show, @user
  end

  def new
    @user = User.new
    authorize! :create, @user
  end
  
  def create
    @user = User.new(params[:user])
    authorize! :create, @user
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
    authorize! :update, @user
  end
  
  def update
    params[:user].delete(:roles) unless admin?
    unless params[:id] == "current"
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    authorize! :update, @user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile."
      redirect_to (admin? && @user != current_user) ? admin_users_url : admin_user_path("current")
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    authorize! :destroy, @user
    @user.destroy
    flash[:notice] = "Successfully destroyed user."
    redirect_to admin_users_url
  end
end
