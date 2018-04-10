class ScreenPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    #owner
    user.theater_owner == true
  end

  def show?
    #owner
    user.theater_owner == true
  end

  def create?
    #owner
    user.theater_owner == true
  end

  def update?
    #owner
    user.theater_owner == true
    record.user == user
  end

  def destroy?
    #owner
    user.theater_owner == true
    record.user == user
  end
end
