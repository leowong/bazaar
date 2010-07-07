class Category < ActiveRecord::Base
  attr_accessible :name, :user_id
  belongs_to :user, :touch => true
  has_many :products
  acts_as_list :scope => :user
end
