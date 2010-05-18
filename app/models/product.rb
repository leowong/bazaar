class Product < ActiveRecord::Base
  attr_accessible :name, :price, :description
  belongs_to :user
  has_many :images, :as => :viewable, :dependent => :destroy

  validates_presence_of :name, :price, :description
  validates_numericality_of :price
  validate :price_must_be_at_least_a_cent

  protected

  def price_must_be_at_least_a_cent
    errors.add(:price, 'should be at least 0.01') if price.nil? || price < 0.01
  end
end
