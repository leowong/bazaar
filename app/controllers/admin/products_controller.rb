class Admin::ProductsController < Admin::BaseController
  uses_tiny_mce

  def index
    # @products = Product.all
    @products = current_user.products
  end
  
  def show
    @product = Product.find(params[:id])
    @image = Image.new(:viewable_id => @product.id, :viewable_type => "Product")
  end

  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(params[:product])
    @product.user_id = current_user.id
    if @product.save
      flash[:notice] = "Successfully created product."
      redirect_to [:admin, @product]
    else
      render :action => 'new'
    end
  end
  
  def edit
    @product = Product.find(params[:id])
  end
  
  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:notice] = "Successfully updated product."
      redirect_to [:admin, @product]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = "Successfully destroyed product."
    redirect_to admin_products_url
  end
end
