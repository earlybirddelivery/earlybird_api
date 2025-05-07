class AddPriceToCartItem < ActiveRecord::Migration[6.0]
  def change
    add_column :cart_items, :price, :decimal
  end
end
