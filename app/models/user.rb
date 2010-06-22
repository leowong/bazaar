class User < ActiveRecord::Base
  attr_accessible :username, :email, :contact, :password, :password_confirmation, :address, :latitude, :longitude, :store_name, :abbreviation, :description, :roles

  acts_as_authentic do |c|
    c.validate_email_field = false
  end

  has_many :products, :dependent => :destroy

  validates_presence_of :username, :store_name, :abbreviation, :contact, :address, :description, :latitude, :longitude
  validate :username_can_not_be_preserved_word
  validates_uniqueness_of :abbreviation
  validates_numericality_of :latitude, :longitude

  named_scope :with_role, lambda { |role| { :conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }
  named_scope :recent, lambda { |*args| {:conditions => ["created_at > ?", (args.first || 8.weeks.ago)]} }

  ROLES = %w[admin moderator seller]
  PRESERVED_WORDS = %w[
    login logout search signin signup signout
    stores products images users
    pages about help blog wiki docs support pricing how contact
    jobs legal tos news success business status
    api dev privacy goodies highlight
  ]

  def self.new_store
    # for SQLite and PostgreSQL only, not MySQL compatible
    ids = with_role(:seller).recent.all(:select => :id, :order => "random()")
    if ids.length == 0
      last
    else
      find(ids[rand(ids.length)].id.to_i)
    end
  end

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end

  def username_can_not_be_preserved_word
    errors.add(:username, I18n.t('users.is_preserved')) if PRESERVED_WORDS.include?(username)
  end
end
