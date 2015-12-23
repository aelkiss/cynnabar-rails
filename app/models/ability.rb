class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
      can :set_owner, Page
    else
      can :read, Page
      can :update, Page, :user_id => user.id
      cannot :index, Page
    end
  end
end
