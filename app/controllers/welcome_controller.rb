class WelcomeController < ApplicationController
  def index
    @products = Product.published.with_images.popular
    @products_count = Product.published.with_images.size
    @stores_count = User.with_role(:seller).size
  end

  def recent
    @products = Product.published.with_images.recent
    @products_count = Product.published.with_images.size
    @stores_count = User.with_role(:seller).size
  end

  def toss
    # For SQLite and PostgreSQL only, not MySQL compatible.
    @products = Product.published.with_images.id_equals(Product.random_ids(20)).all(:order => "random()", :limit => 20)
    render :layout => false
  end
end
