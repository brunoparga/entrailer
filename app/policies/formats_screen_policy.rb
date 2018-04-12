class FormatsScreenPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    #owner
    user.role == 'theater_owner'
  end

  def create?
    #owner
    user.role == 'theater_owner'
  end

  def update?
    #owner
    user.role == 'theater_owner'
  end

  def destroy?
    #owner
    user.role == 'theater_owner'
  end
end
