class FormatsScreenPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
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

  def update?
    #owner
    record.user == user
    user.theater_owner == true
  end

  def destroy?
    #owner
    record.user == user
    user.theater_owner == true
  end
end
