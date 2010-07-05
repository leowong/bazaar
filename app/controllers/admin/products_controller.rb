class Admin::ProductsController < Admin::BaseController
  uses_tiny_mce

  def index
    @products = current_user.products.ascend_by_created_at
    authorize! :read, Product
  end
  
  def show
    @product = Product.find_by_permalink(params[:id])
    authorize! :update, @product
    @image = Image.new(:viewable_id => @product.id, :viewable_type => "Product")
  end

  def new
    @product = Product.new
    authorize! :create, @product
  end
  
  def create
    @product = Product.new(params[:product])
    @product.user_id = current_user.id
    authorize! :create, @product
    if @product.save
      @product.update_permalink
      flash[:notice] = t('messages.created_successful')
      redirect_to [:admin, @product]
    else
      render :action => 'new'
    end
  end
  
  def edit
    @product = Product.find_by_permalink(params[:id])
    authorize! :update, @product
  end
  
  def update
    @product = Product.find_by_permalink(params[:id])
    authorize! :update, @product
    if @product.update_attributes(params[:product])
      flash[:notice] = t('messages.updated_successful')
      redirect_to [:admin, @product]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @product = Product.find_by_permalink(params[:id])
    authorize! :destroy, @product
    @product.destroy
    flash[:notice] = t('messages.destroyed_successful')
    redirect_to admin_products_url
  end

  def sort
    @product = Product.find(params[:id])
    authorize! :update, @product
    params[:image].each_with_index do |id, index|
      authorize! :update, Image.find(id)
      Image.update_all(['position=?', index+1], ['id=?', id])
    end
    @product.touch
    render :nothing => true
  end
end
