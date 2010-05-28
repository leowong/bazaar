class WelcomeController < ApplicationController
  def index
    @products = Product.all :order => "updated_at DESC", :limit => 20
  end
end
