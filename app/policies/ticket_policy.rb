class TicketPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def show?
    #user
    record.user == user
  end

  def create?
    #user
    true
  end

end
