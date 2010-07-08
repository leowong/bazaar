class SitemapController < ApplicationController
  def sitemap
    @pages = Page.all :select => 'slug, updated_at'
    @stores = User.with_role(:seller).all :select => 'username, updated_at', :order => 'updated_at DESC', :limit => 800
    @products = Product.published.all :select => 'permalink, updated_at', :order => 'updated_at DESC', :limit => 49000

    headers["Content-Type"] = "text/xml"
    headers["Last-Modified"] = @stores[0].updated_at.httpdate if @stores[0]

    render :layout => false
  end
end
