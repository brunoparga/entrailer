class AddBannerUrlToFilmTitles < ActiveRecord::Migration[5.1]
  def change
    add_column :film_titles, :banner_url, :string
  end
end
