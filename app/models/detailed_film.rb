class DetailedFilm < ApplicationRecord
  belongs_to :film_title
  delegate :title, to: :film_title

  belongs_to :format

  has_many :screenings
  has_many :sessions

  enum speech: { dublado: 0, legendado: 1, brasileiro: 2, mudo: 3 }

  validates :film_title_id, presence: true
  validates :format_id, presence: true
  validates :speech, presence: true, uniqueness: { scope: [:film_title_id, :format_id] }

  # This method ensures the owner sees an intelligible string rather than a
  # jumble of an Object in the screening#new page.
  def prepare_for_display
    ["#{film_title.title} #{speech} #{format.name}", "#{id}"]
  end
end
