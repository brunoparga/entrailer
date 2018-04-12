class SoldTicket < ApplicationRecord
  belongs_to :screening
  belongs_to :user

  validates :screening, presence: true
  validates :user, presence: true
  validates :price_centavos, presence: true
  validates :purchase_time, presence: true
  validate :purchase_time_must_be_lte_closing_time

  monetize :price_centavos

  def title
    self.screening.detailed_film.film_title.title
  end

  private

  def purchase_time_must_be_lte_closing_time
    if purchase_time > screening.closing_time
      errors.add(:purchase_time, 'must be before screening closing time')
    end
  end
end
