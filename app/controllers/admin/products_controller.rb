class Admin::ProductsController < Admin::BaseController
  uses_tiny_mce

  def index
    @products = current_user.products
    authorize! :read, Product
  end
  
  def show
    @product = Product.find(params[:id])
    authorize! :read, @product
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
      flash[:notice] = "Successfully created product."
      redirect_to [:admin, @product]
    else
      render :action => 'new'
    end
  end
  
  def edit
    @product = Product.find(params[:id])
    authorize! :update, @product
  end
  
  def update
    @product = Product.find(params[:id])
    authorize! :update, @product
    if @product.update_attributes(params[:product])
      flash[:notice] = "Successfully updated product."
      redirect_to [:admin, @product]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @product = Product.find(params[:id])
    authorize! :update, @product
    @product.destroy
    flash[:notice] = "Successfully destroyed product."
    redirect_to admin_products_url
  end
end
