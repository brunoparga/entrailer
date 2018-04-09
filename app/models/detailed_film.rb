class DetailedFilm < ApplicationRecord
  belongs_to :film_title
  belongs_to :format
  has_many :sessions

  enum speech: { dubbed: 0, subtitled: 1, original: 2, silent: 3 }

  validates :film_title_id, presence: true
  validates :format_id, presence: true
  validates :speech, presence: true, uniqueness: { scope: [:film_title_id, :format_id] }
end
