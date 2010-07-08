class SitemapController < ApplicationController
  def sitemap
    # @entries = Item.find(:all, :select => 'id, updated_at', :order => 'updated_at DESC', :limit => 49000)
    # @products = Product.published.all :select => 'permalink, updated_at', :order => 'updated_at DESC', :limit => 49000
    @products = Product.all
    # @stores = Product.
    # @categories = Category.find(:all, :select => 'id', :order => 'position')
    # @pages = Page.find(:all, :select => 'slug')

    headers["Content-Type"] = "text/xml"
    headers["Last-Modified"] = @products[0].updated_at.httpdate if @products[0]

    render :layout => false
  end
end
