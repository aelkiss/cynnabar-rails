# frozen_string_literal: true
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    approved_ability(user) if user.approved?
    heraldic_ability if user.herald?

    if user.admin?
      admin_ability
    else
      default_ability
    end
  end

  private

  def approved_ability(user)
    can :update, Page, user_id: user.id
    can :update, Recipient, id: user.recipient_id if user.recipient_id
    can :update, User, id: user.id
  end

  def admin_ability
    can :manage, :all
    can :set_owner, Page
  end

  def default_ability
    # default permission for everyone
    can :read, Page
    cannot :index, Page

    can :index, Office

    can :read, Awarding
    can :read, Award
    can :read, Recipient
    can :armory, Recipient
    can :autocomplete_award_name, Award
    can :autocomplete_recipient_name, Recipient
  end

  def heraldic_ability
    can :manage, Awarding
    can :create, Recipient
    can :update, Recipient
  end
end
