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
  end
end
