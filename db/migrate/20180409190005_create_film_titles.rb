class CreateFilmTitles < ActiveRecord::Migration[5.1]
  def change
    create_table :film_titles do |t|
      t.string :title

      t.timestamps
    end
  end
end
