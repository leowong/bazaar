class PagesController < ApplicationController
  def show
    @page = Page.find_by_slug(params[:id])
    @user = User.find_by_username('admin')
  end
end
