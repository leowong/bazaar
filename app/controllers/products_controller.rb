class ProductsController < ApplicationController
  def index
    @search = Product.name_like_all(params[:q].to_s.split)
    if params[:order] == "pa"
      @search = @search.ascend_by_price
    elsif params[:order] == "pd"
      @search = @search.descend_by_price
    else
      @search = @search.ascend_by_price
    end
    @products = @search.paginate :page => params[:page], :per_page => 10
  end
  
  def show
    @product = Product.find(params[:id])
  end
end
