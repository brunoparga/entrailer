class AddImDbIdToFilmTitles < ActiveRecord::Migration[5.1]
  def change
    add_column :film_titles, :imdb_id, :string, null: false
  end
end
