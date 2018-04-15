class AddSynopsisToFilmTitles < ActiveRecord::Migration[5.1]
  def change
    add_column :film_titles, :synopsis, :text
  end
end
