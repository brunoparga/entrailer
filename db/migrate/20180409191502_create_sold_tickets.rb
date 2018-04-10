class CreateSoldTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :sold_tickets do |t|
      t.datetime :purchase_time
      t.references :screening, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
