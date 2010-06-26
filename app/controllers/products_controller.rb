class ProductsController < ApplicationController
  def index
    @search = Product.with_images.name_like_all(params[:q].to_s.split)

    if params[:order] == "pvd"
      @search = @search.descend_by_pageviews_count
    elsif params[:order] == "pa"
      @search = @search.ascend_by_price
    elsif params[:order] == "pd"
      @search = @search.descend_by_price
    else
      @search = @search.descend_by_pageviews_count
    end

    @products_count = @search.size
    @products = @search.paginate :page => params[:page], :per_page => 15
  end
  
  def show
    @product = Product.find_by_permalink(params[:id])
    Product.increment_counter(:pageviews_count, @product.id)
  end
end
