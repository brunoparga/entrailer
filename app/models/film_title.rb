class FilmTitle < ApplicationRecord
  has_many :detailed_films
  has_many :screenings, through: :detailed_films

  validates :title, presence: true

  # TODO: validar IMDb -> uniquenes

  include PgSearch
  pg_search_scope :search_by_title,
    against: [ :title ],
    using: {
      tsearch: { prefix: true }
    }
end
