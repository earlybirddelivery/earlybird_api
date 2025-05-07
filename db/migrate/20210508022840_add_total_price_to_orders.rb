class AddTotalPriceToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :total_price, :decimal
    add_column :orders, :date_of_order, :date
  end
end
