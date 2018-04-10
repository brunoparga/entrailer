class FormatPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    #owner
    user.theater_owner == true
  end

  def create?
    #owner
    user.theater_owner == true
  end
end
