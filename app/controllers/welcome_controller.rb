class WelcomeController < ApplicationController
  def index
    @products = Product.find :all, :order => "created_at DESC"
  end
end
