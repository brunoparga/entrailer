class SoldTicket < ApplicationRecord
  belongs_to :screening
  belongs_to :user

  validates :screening, presence: true
  validates :user, presence: true
  validates :price, presence: true    ## MUDAR PARA CENTAVOS
  validates :purchase_time, presence: true    ## Botar null:false na DB aqui etc
  validate :purchase_time_must_be_lte_closing_time

  private

  def purchase_time_must_be_lte_closing_time
    if purchase_time > screening.closing_time
      errors.add(:purchase_time, 'must be before screening closing time')
    end
  end
end
