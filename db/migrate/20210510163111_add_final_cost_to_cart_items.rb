class AddFinalCostToCartItems < ActiveRecord::Migration[6.0]
  def change
    add_column :cart_items, :cost, :decimal
    add_column :order_items, :cost, :decimal
  end
end
