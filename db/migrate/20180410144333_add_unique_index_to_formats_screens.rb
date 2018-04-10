class AddUniqueIndexToFormatsScreens < ActiveRecord::Migration[5.1]
  def change
    add_index :formats_screens, [:format_id, :screen_id], unique: true
  end
end
