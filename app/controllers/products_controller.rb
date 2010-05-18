class ProductsController < ApplicationController
  def index
    @search = Product.name_like_all(params[:search].to_s.split)
    @products = @search.all
  end
  
  def show
    @product = Product.find(params[:id])
  end
end
