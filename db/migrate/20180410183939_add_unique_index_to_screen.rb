class AddUniqueIndexToScreen < ActiveRecord::Migration[5.1]
  def change
    add_index :screens,
              %i[name],
              unique: true,
              name: 'screens_uniqueness_index'
  end
end
