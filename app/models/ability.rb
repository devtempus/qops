class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new # guest user (not logged in)

      alias_action :create, :read, :update, :destroy, :to => :crud
      alias_action :update, :destroy, :to => :modify

      if user.admin?
        can :crud, [Quotation, User, Tag]
      elsif user.api?
        can [:create, :update], [Quotation, User, Tag]
      elsif user.moderator?
        can :modify, [Quotation, User, Tag]
      elsif user.banned?
        can :read, Quotation
      else
        can :read, :all
      end

    #WIKI
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
