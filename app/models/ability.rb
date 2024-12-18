class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    if user.admin?
      can :manage, :all
    elsif user.warehouse_manager?
      can :read, Warehouse
      can :create, StockMovement
    elsif user.store_operator?
      can :read, StockMovement
      can :create, StockMovement
      can :read, :store_analysis
      can :create, :store_analysis
    else
      can :read, Product
    end
  end
end
