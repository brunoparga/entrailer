class RemoveColumnsFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :admin
    remove_column :users, :theater_owner
  end
end
