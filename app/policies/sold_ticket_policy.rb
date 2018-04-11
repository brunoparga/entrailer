class SoldTicketPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
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
