class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.approved?
      can :update, Page, :user_id => user.id
      can :update, Recipient, :id => user.recipient_id
    end

    if user.admin?
      can :manage, :all
      can :set_owner, Page
    else
      # default permission for everyone
      can :read, Page
      cannot :index, Page

      can :index, Office

      can :read, Awarding
      can :read, Award
      can :read, Recipient
      can :armory, Recipient
    end

    if user.herald?
      # specific permissions for herald role
      can :manage, Awarding
      can :create, Recipient
      can :update, Recipient
      can :autocomplete_award_name, Award
      can :autocomplete_recipient_name, Recipient
    end
  end
end
