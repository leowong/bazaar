# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication # lib/authentication.rb

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  before_filter :set_cache_buster, :redirect_domain

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message # "Access denied."
    redirect_to root_url
  end

  protected

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def redirect_domain
    if request.env['HTTP_HOST'] == "www.xuncheng.net"
      redirect_to request.url.gsub('www.xuncheng.net', 'xuncheng.net'), :status => 301
    end
  end
end
