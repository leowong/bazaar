class WelcomeController < ApplicationController
  def index
    @products = Product.all :order => "created_at DESC", :limit => 20
  end
end
