class ReplaceDetailedFilmsAndFilmTitlesWithFilms < ActiveRecord::Migration[5.1]
  def change
    drop_table :detailed_films
    drop_table :film_titles
    create_table :films do |t|
      t.string :title, null: false
      t.string :img_url
      t.string :banner_url
      t.text :synopsis

      t.timestamps
    end
    add_column :screenings, :speech, :integer, null: false
    add_reference :screenings, :format, index: true
  end
end
