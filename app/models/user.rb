class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation, :address, :latitude, :longitude, :store_name, :description
  acts_as_authentic
  has_many :products, :dependent => :destroy

  validates_presence_of :username, :email, :address, :latitude, :longitude, :store_name
end
