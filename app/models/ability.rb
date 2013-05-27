class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new auth_status: "guest"
    if user.user_auth?
      can :create, Involvement
      # refactor this later
      can :add_involvement, User do |user_shown|
        user_shown == user
      end

      can [:update, :destroy], Involvement do |involvement|
        involvement.try(:user) == user
      end

      can [:update, :destroy], Profile do |profile|
        profile.try(:user) == user
      end

      can :create, Follow
      can :destroy, Follow do |follow|
        follow.try(:user) == user
      end
      can :read, Post
      can :read, User
    end

    if user.incomplete_auth?

      cannot :create, Follow
      cannot :read, Post
      cannot :read, User do |user_profile|
        user_profile != user
      end

    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
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
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
