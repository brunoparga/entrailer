class FilmTitle < ApplicationRecord
  has_many :detailed_films

  validates :title, presence: true

  # validar IMDb -> uniqueness
end
