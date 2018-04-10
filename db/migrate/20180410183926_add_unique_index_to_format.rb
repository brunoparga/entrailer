class AddUniqueIndexToFormat < ActiveRecord::Migration[5.1]
  def change
    add_index :formats,
              %i[name],
              unique: true,
              name: 'format_uniqueness_index'
  end
end
