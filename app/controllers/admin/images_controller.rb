class Admin::ImagesController < Admin::BaseController
  def new
    flash[:notice] = "To upload an image, please go to a specific product first."
    redirect_to admin_products_url
  end
  
  def create
    @image = Image.new(params[:image])
    if @image.save
      flash[:notice] = "Successfully created image."
      redirect_to admin_product_url(@image.viewable)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @image = Image.find(params[:id])
  end
  
  def update
    @image = Image.find(params[:id])
    if @image.update_attributes(params[:image])
      flash[:notice] = "Successfully updated image."
      redirect_to admin_product_url(@image.viewable)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    flash[:notice] = "Successfully destroyed image."
    redirect_to admin_product_url(@image.viewable)
  end
end
