class SearchController < ApplicationController
  # OPTIMIZE finding a better solution for multi-type searching
  def index
    if params[:type] == "stores"
      redirect_to request.request_uri.gsub(/&?type=stores/, '').gsub('/search?', '/stores?')
    else # params[:type] == "products" || params[:type].nil?
      redirect_to request.request_uri.gsub(/&?type=products/, '').gsub('/search?', '/products?')
    end
  end
end
