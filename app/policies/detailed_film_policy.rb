class DetailedFilmPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    #only owners
    user.theater_owner == true
  end

  def show?
    true
  end

  def create?
    #only owners
    user.theater_owner == true
  end

  def update?
    #owners
    record.user == user
    user.theater_owner == true
  end


end
