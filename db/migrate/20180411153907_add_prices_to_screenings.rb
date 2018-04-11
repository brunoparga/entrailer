class AddPricesToScreenings < ActiveRecord::Migration[5.1]
  def change
    add_monetize :screenings, :min_price, currency: { present: false }
    add_monetize :screenings, :max_price, currency: { present: false }
  end
end
