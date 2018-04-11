class AddReferenceToScreens < ActiveRecord::Migration[5.1]
  def change
    add_reference :screens, :user, index: true
  end
end
