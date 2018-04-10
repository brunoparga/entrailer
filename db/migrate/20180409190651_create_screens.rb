class CreateScreens < ActiveRecord::Migration[5.1]
  def change
    create_table :screens do |t|
      t.integer :capacity, null: false

      t.timestamps
    end
  end
end
