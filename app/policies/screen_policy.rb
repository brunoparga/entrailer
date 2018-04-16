class ScreenPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.role == 'theater_owner'
  end

  def show?
    user.role == 'theater_owner'
    record.user == user
  end

  def create?
    #owner
    user.role == 'theater_owner'
  end

  def update?
    #owner
    user.role == 'theater_owner'
    record.user == user
  end

  def destroy?
    #owner
    user.role == 'theater_owner'
    record.user == user
  end
end
