class AddTrailPacksColumns < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :available_as_trail_pack, :boolean, default: false

    add_column :cart_items, :trail_pack, :boolean, default: false
    add_column :cart_items, :trail_days, :integer

    add_column :order_items, :trail_days, :integer
    add_column :order_items, :trail_pack, :boolean, default: false
  end
end
