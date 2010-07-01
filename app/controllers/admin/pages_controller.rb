class Admin::PagesController < Admin::BaseController
  def index
    @pages = Page.all
    authorize! :read, Page
  end
  
  def show
    @page = Page.find_by_slug(params[:id])
    authorize! :read, @page
  end
  
  def new
    @page = Page.new
    authorize! :create, @page
  end
  
  def create
    @page = Page.new(params[:page])
    authorize! :create, @page
    if @page.save
      flash[:notice] = "Successfully created page."
      redirect_to [:admin, @page]
    else
      render :action => 'new'
    end
  end
  
  def edit
    @page = Page.find_by_slug(params[:id])
    authorize! :update, @page
  end
  
  def update
    @page = Page.find_by_slug(params[:id])
    authorize! :update, @page
    if @page.update_attributes(params[:page])
      flash[:notice] = "Successfully updated page."
      redirect_to [:admin, @page]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @page = Page.find_by_slug(params[:id])
    authorize! :destroy, @page
    @page.destroy
    flash[:notice] = "Successfully destroyed page."
    redirect_to admin_pages_url
  end
end
