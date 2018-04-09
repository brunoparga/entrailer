class CreateDetailedFilms < ActiveRecord::Migration[5.1]
  def change
    create_table :detailed_films do |t|
      t.integer :speech
      t.references :film_title, foreign_key: true
      t.references :format, foreign_key: true

      t.timestamps
    end
  end
end
