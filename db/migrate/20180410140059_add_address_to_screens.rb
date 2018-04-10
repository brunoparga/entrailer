class AddAddressToScreens < ActiveRecord::Migration[5.1]
  def change
    add_column :screens, :address, :text, null: false
  end
end
