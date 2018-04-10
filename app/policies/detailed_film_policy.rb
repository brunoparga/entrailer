class DetailedFilmPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
end
