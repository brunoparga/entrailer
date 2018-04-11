class FilmTitlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    #everyone
    true
  end

  def show?
    #everyone
    true
  end

  def create?
    #owner
    user.role == :theater_owner
  end


end
