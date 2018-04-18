# This policy is only to be user by theater owners!

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    user.role != 'theater_owner'
  end

  def update?
    user.role != 'theater_owner'
  end

  def show?
    user.role == 'theater_owner'
    record == user
  end
end
