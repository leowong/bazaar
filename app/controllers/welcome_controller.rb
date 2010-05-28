class WelcomeController < ApplicationController
  def index
    @products = Product.with_images :order => "updated_at DESC", :limit => 20
  end
end
