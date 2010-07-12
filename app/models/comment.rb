class Comment < ActiveRecord::Base
  attr_accessible :user_id, :name, :contact, :content
  belongs_to :user

  validates_presence_of :user_id, :name, :content
end
