class ScreeningPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    #anyone
    true
  end

  def show?
    #anyone
    true
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
