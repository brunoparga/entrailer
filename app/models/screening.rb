class Screening < ApplicationRecord
  belongs_to :detailed_film
  belongs_to :screen
  has_many :sold_tickets

  validates :session_time, presence: true
  validates :closing_time, presence: true
  validates :initial_tickets, presence: true
  validate :initial_tickets_must_be_lte_screen_capacity

  private

  def initial_tickets_must_be_lte_screen_capacity
    if initial_tickets > screen.capacity
      errors.add(:initial_tickets, "must be <= screen capacity")
    end
  end
end
