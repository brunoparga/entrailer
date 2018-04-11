class DetailedFilmPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    #only owners
    user.role == 'theater_owner'
  end

  def show?
    true
  end

  def create?
    #only owners
    user.role == 'theater_owner'
  end

  def update?
    #owners
    record.user == user
    user.role == 'theater_owner'
  end


end
