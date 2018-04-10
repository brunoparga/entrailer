class AddPriceToSoldTickets < ActiveRecord::Migration[5.1]
  def change
    add_monetize :sold_tickets, :price, currency: { present: false }
  end
end
