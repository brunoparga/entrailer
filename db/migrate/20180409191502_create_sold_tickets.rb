class CreateSoldTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :sold_tickets do |t|
      t.integer :price
      t.datetime :purchase_time
      t.references :screening, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
