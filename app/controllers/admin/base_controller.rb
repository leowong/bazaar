class Admin::BaseController < ApplicationController
  before_filter :login_required

  layout "admin"

  def current_ability
    @current_ability ||= AdminAbility.new(current_user)
  end
end
