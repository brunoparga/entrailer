class CreateFormatsScreens < ActiveRecord::Migration[5.1]
  def change
    create_table :formats_screens do |t|
      t.references :format, null: false, foreign_key: true
      t.references :screen, null: false, foreign_key: true

      t.timestamps
    end
  end
end
