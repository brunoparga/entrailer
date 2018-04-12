class AddColumnsToSoldTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :sold_tickets, :status, :string
    add_column :sold_tickets, :payment, :jsonb
  end
end
