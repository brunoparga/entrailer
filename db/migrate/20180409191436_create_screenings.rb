class CreateScreenings < ActiveRecord::Migration[5.1]
  def change
    create_table :screenings do |t|
      t.integer :initial_tickets, null: false
      t.datetime :session_time
      t.datetime :closing_time
      t.references :detailed_film, null: false, foreign_key: true
      t.references :screen, null: false, foreign_key: true

      t.timestamps
    end
  end
end
