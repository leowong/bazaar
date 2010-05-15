class Product < ActiveRecord::Base
  attr_accessible :name, :description
  belongs_to :user
  has_many :images, :as => :viewable, :dependent => :destroy
end
