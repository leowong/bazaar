class Product < ActiveRecord::Base
  attr_accessible :name, :price, :description
  belongs_to :user, :touch => true
  has_many :images, :as => :viewable, :dependent => :destroy

  validates_presence_of :name, :price, :description
  validates_numericality_of :price
  validates_uniqueness_of :permalink
  validate :price_must_be_at_least_a_cent

  named_scope :with_images, :conditions => ['assets_count > 0']

  def self.random_ids(total)
    # for SQLite and PostgreSQL only, not MySQL compatible
    ps = with_images.all :select => :id , :order => "random()"
    ids = []
    until ids.length == total || ps.length == 0 do
      # id =  ps[rand(ps.length)]["id"].to_i
      id = ps.pop.id.to_i
      unless ids.include?(id)
        ids << id
      end
    end
    ids
  end

  def has_images?
    assets_count > 0
  end

  def to_param
    permalink
  end

  def update_permalink
    pl = Digest::MD5.hexdigest(id.to_s + created_at.to_s)
    while Product.find_by_permalink(pl) do
      pl = Digest::MD5.hexdigest(pl)
    end
    update_attribute(:permalink, pl)
  end

  protected

  def price_must_be_at_least_a_cent
    errors.add(:price, I18n.t('users.should_be_at_least_001')) if price.nil? || price < 0.01
  end
end
