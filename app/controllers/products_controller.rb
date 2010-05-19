class ProductsController < ApplicationController
  def index
    @search = Product.name_like_all(params[:q].to_s.split)
    if params[:order] == "pa"
      @products = @search.ascend_by_price
    elsif params[:order] == "pd"
      @products = @search.descend_by_price
    else
      @products = @search.ascend_by_price
    end
  end
  
  def show
    @product = Product.find(params[:id])
  end
end
