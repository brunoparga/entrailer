class FormatPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
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
end
