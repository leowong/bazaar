class CommentsController < ApplicationController
  def index
    @comments = Comment.all :order => 'created_at DESC'
  end
  
  def show
    @comment = Comment.find(params[:id])
  end
  
  def new
    redirect_to root_url
  end
  
  def create
    return_to = params[:comment][:return_to]
    params[:comment].delete(:return_to)
    if current_user
      params[:comment][:composer_id] = current_user.id
      params[:comment][:name] = current_user.abbreviation
      params[:comment][:contact] = current_user.contact
    end
    @comment = Comment.new(params[:comment])
    if @comment.save
      if @comment.composer_id
        if @comment.composer_id == @comment.user_id || @comment.user_id == User.find_by_username('admin').id && User.find(@comment.composer_id).role?(:admin)
          @comment.update_attribute(:news, true)
        end
      end
      flash[:notice] = t('messages.published_successful')
      redirect_to return_to
    else
      redirect_to return_to
    end
  end
end
