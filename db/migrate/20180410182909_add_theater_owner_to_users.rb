class AddTheaterOwnerToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :theater_owner, :boolean
  end
end
