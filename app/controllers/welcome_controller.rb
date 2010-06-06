class WelcomeController < ApplicationController
  def index
    @products = Product.find :all, :order => "pageviews_count DESC", :limit => 15
    @products_count = Product.with_images.size
    @stores_count = User.with_role(:seller).size
  end

  def toss
    # For SQLite and PostgreSQL only, not MySQL compatible.
    @products = Product.with_images.id_equals(Product.random_ids(15)).all(:order => "random()", :limit => 15)
    render :layout => false
  end
end
