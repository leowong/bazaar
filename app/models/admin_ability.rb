class AdminAbility
  include CanCan::Ability
  def initialize(user)
    user ||= User.new # guest user

    if user.role? :admin
      can :manage, :all
    elsif user.role? :seller
      can [:show, :update], User do |u|
        u == user
      end

      can :create, Product
      can :read, Product
      can [:update, :destroy], Product do |p|
        p.try(:user) == user
      end

      can :create, Image
      can [:update, :destroy], Image do |i|
        i.try(:viewable).try(:user) == user
      end
    end
  end
end
