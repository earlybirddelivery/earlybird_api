class AddCountToCartItems < ActiveRecord::Migration[6.0]
  def change
    add_column :cart_items, :count, :integer
  end
end
