class Comment < ActiveRecord::Base
  attr_accessible :user_id, :name, :contact, :content, :composer_id
  belongs_to :user

  validates_presence_of :user_id, :name, :content

  named_scope :from_manager, :conditions => ['composer_id > ?', 0]
  named_scope :recent, :order => "updated_at DESC", :limit => 10

  def return_to=(uri)
    @return_to_uri = uri
  end

  def return_to
    @return_to_uri
  end
end
