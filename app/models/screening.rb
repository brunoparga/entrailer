class Screening < ApplicationRecord
  belongs_to :detailed_film
  belongs_to :screen
  has_many :sold_tickets

  validates :session_time,
            presence: true,
            uniqueness: { scope: %i[detailed_film_id screen_id] }
  validates :closing_time, presence: true
  validates :initial_tickets, presence: true
  validate :initial_tickets_must_be_lte_screen_capacity
  validate :screen_must_have_film_format

  private

  def initial_tickets_must_be_lte_screen_capacity
    if initial_tickets > screen.capacity
      errors.add(:initial_tickets, "must be <= screen capacity")
    end
  end

  def screen_must_have_film_format
    unless screen.formats.include?(detailed_film.format)
      errors.add(:screen, 'must have proper format for film')
    end
  end
end
