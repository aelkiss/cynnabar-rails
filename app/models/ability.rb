class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
    else
      can :read, Page
#      can :update, Page do |page|
#        page.user_id != nil and page.user_id == user.id
#      end
      can :update, Page, :user_id => user.id
      cannot :index, Page
    end
  end
end
