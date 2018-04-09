class AddUniqueIndexToDetailedFilms < ActiveRecord::Migration[5.1]
  def change
    add_index :detailed_films, [:film_title_id, :speech, :format_id], unique: true
  end
end
