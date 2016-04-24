class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here.
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    user ||= RegularUser.new # guest user (not logged in)

    if user.new_record?
      not_signed_in
    elsif user.admin?
      signed_in_as_admin user
    elsif user.manager?
      signed_in_as_manager user
    else
      signed_in_as_normal_user user
    end
  end

  def not_signed_in
    cannot :manage, GuestUser
    cannot :manage, RegularUser
    cannot :manage, Transaction
  end

  def signed_in_as_normal_user(user)
    can :manage, RegularUser, id: user.id
    can :manage, GuestUser, regular_user_id: user.id
    can :read, Transaction, regular_user_id: user.id
  end

  def signed_in_as_manager(user)
    signed_in_as_normal_user(user)
    can :read, GuestUser
    can :read, RegularUser
    can :read, Transaction
  end

  def signed_in_as_admin(user)
    signed_in_as_manager(user)
    can :manage, RegularUser
    can :manage, GuestUser
    can :manage, Transaction
    can :manage, Version
  end
end
