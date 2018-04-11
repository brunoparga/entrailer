class AddUniqueIndexToScreenings < ActiveRecord::Migration[5.1]
  def change
    add_index :screenings,
              %i[session_time detailed_film_id screen_id],
              unique: true,
              name: 'film_screen_time_uniqueness_index'
  end
end
