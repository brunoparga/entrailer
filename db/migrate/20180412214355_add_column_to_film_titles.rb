class AddColumnToFilmTitles < ActiveRecord::Migration[5.1]
  def change
    add_column :film_titles, :img_url, :string
  end
end
