class CreateDetailedFilms < ActiveRecord::Migration[5.1]
  def change
    create_table :detailed_films do |t|
      t.integer :speech, null: false
      t.references :film_title, null: false, foreign_key: true
      t.references :format, null: false, foreign_key: true

      t.timestamps
    end
  end
end
