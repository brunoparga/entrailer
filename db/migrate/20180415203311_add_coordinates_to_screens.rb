class AddCoordinatesToScreens < ActiveRecord::Migration[5.1]
  def change
    add_column :screens, :latitude, :float
    add_column :screens, :longitude, :float
  end
end
