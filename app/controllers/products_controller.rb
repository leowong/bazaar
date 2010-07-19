class ProductsController < ApplicationController
  def index
    if (params[:q].blank?)
      @search = Product.published.with_images.name_like_all(params[:q].to_s.split)
    else
      @search = Product.published.with_images.name_or_category_name_like_all(params[:q].to_s.split)
    end

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
    @products = @search.paginate :select => 'DISTINCT products.*', :page => params[:page], :per_page => 20
  end
  
  def show
    @product = Product.find_by_permalink(params[:id])
    @user = @product.user
    Product.increment_counter(:pageviews_count, @product.id)
  end
end
