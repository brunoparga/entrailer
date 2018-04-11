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

  def new?
    # TODO: ver se é isso mesmo
    true
  end

  def show?
    #anyone
    true
  end

  def create?
    #owner
    ['theater_owner', 'admin'].include?(user.role)
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
