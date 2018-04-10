class FilmTitle < ApplicationRecord
  has_many :detailed_films

  validates :title, presence: true

  # incluir IMDb -> uniqueness
end
