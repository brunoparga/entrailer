# This policy is only to be user by theater owners!

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.role != 'theater_owner'
  end

  def show?
    user.role == 'theater_owner'
    record.user == user
  end
end
