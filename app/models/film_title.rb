class FilmTitle < ApplicationRecord
  has_many :detailed_films

  validates :title, presence: true

  include PgSearch
  pg_search_scope :search_by_title,
    against: [ :title ],
    using: {
      tsearch: { prefix: true }
    }
  # validar IMDb -> uniqueness
end
