class AddScreenImgToScreens < ActiveRecord::Migration[5.1]
  def change
    add_column :screens, :screen_img, :string
  end
end
