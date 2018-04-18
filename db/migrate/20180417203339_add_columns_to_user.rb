class AddColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :cnpj, :string, default: nil
    add_column :users, :address, :string
  end
end
