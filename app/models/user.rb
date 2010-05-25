class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation, :address, :latitude, :longitude, :store_name, :description, :roles
  acts_as_authentic
  has_many :products, :dependent => :destroy

  validates_presence_of :username, :email, :address, :latitude, :longitude, :store_name

  named_scope :with_role, lambda { |role| { :conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }

  ROLES = %w[admin moderator seller]

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end
end
