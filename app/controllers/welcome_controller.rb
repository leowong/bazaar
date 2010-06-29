class WelcomeController < ApplicationController
  def index
    @products = Product.with_images.popular
    @products_count = Product.with_images.size
    @stores_count = User.with_role(:seller).size
  end

  def recent
    @products = Product.with_images.recent
    @products_count = Product.with_images.size
    @stores_count = User.with_role(:seller).size
  end

  def toss
    # For SQLite and PostgreSQL only, not MySQL compatible.
    @products = Product.with_images.id_equals(Product.random_ids(15)).all(:order => "random()", :limit => 15)
    render :layout => false
  end
end
