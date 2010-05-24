class AdminAbility
  include CanCan::Ability
  def initialize(user)
    user ||= User.new # guest user

    if user.role? :admin
      can :manage, :all
    elsif user.role? :seller
      can :read, User
      can :update, User do |u|
        u == user
      end

      can :read, Product
      can :create, Product
      can :update, Product do |p|
        p.try(:user) == user
      end
      can :destroy, Product do |p|
        p.try(:user) == uesr
      end

      can :read, Image
      can :create, Image
      can :update, Image do |i|
        i.try(:viewable).try(:user) == user
      end
      can :destroy, Image do |i|
        i.try(:viewable).try(:user) == user
      end
    end
  end
end
