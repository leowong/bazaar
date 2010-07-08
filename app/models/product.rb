class Product < ActiveRecord::Base
  attr_accessible :name, :price, :description, :images_attributes, :tag_names, :category_id
  belongs_to :user, :touch => true
  belongs_to :category
  has_many :images, :as => :viewable, :order => "position", :dependent => :destroy
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings

  accepts_nested_attributes_for :images, :reject_if => :all_blank, :allow_destroy => true

  validates_presence_of :name, :price, :description
  validates_numericality_of :price
  validates_uniqueness_of :permalink
  validate :price_must_be_at_least_a_cent

  named_scope :with_images, :conditions => ['assets_count > 0']
  named_scope :popular, :order => "pageviews_count DESC", :limit => 15
  named_scope :recent, :order => "updated_at DESC", :limit => 15
  named_scope :published, :conditions => { :published => true }

  def self.random_ids(total)
    # for SQLite and PostgreSQL only, not MySQL compatible
    ps = published.with_images.all :select => :id , :order => "random()"
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

  def tag_names=(names)
    self.tags = Tag.with_names(names.strip.split(/\s*[,，]\s*/))
  end

  def tag_names
    tags.map(&:name).join(', ')
  end

  protected

  def price_must_be_at_least_a_cent
    errors.add(:price, I18n.t('users.should_be_at_least_001')) if price.nil? || price < 0.01
  end
end
