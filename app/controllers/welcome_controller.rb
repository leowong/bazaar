class WelcomeController < ApplicationController
  def index
    # For SQLite and PostgreSQL only, not MySQL compatible.
    @products = Product.with_images.id_equals(Product.random_ids(15)).all(:order => "random()", :limit => 15)
  end

  def toss
    @products = Product.with_images.id_equals(Product.random_ids(15)).all(:order => "random()", :limit => 15)
    render :layout => false
  end    
end
