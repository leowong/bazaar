# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication # lib/authentication.rb

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  before_filter :redirect_domain

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message # "Access denied."
    redirect_to root_url
  end

  protected

  def redirect_domain
    if request.env['HTTP_HOST'] == "www.xuncheng.net"
      response.headers["Status"] = "301 Moved Permanently"
      redirect_to request.url.gsub('www.xuncheng.net', 'xuncheng.net')
    end
  end
end
