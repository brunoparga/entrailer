class AddNameToScreens < ActiveRecord::Migration[5.1]
  def change
    add_column :screens, :name, :string, null: false
  end
end
