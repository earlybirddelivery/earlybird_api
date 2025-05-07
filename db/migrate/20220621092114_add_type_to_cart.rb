class AddTypeToCart < ActiveRecord::Migration[6.0]
  def change
    add_column :cart_items, :cart_item_type, :string
    add_column :cart_items, :quantity_per_day, :integer, default: 1
    add_column :cart_items, :total_quantity, :integer
    add_column :cart_items, :subscription_start_date, :date
    add_column :cart_items, :subscription_end_date, :date
    add_column :cart_items, :subscription_type, :string
    add_reference :cart_items, :subscriber, foreign_key: { to_table: :users }

    add_column :order_items, :order_item_type, :string
    add_column :order_items, :quantity_per_day, :integer, default: 1
    add_column :order_items, :total_quantity, :integer
    add_column :order_items, :subscription_start_date, :date
    add_column :order_items, :subscription_end_date, :date
    add_column :order_items, :subscription_type, :string
    add_reference :order_items, :subscriber, foreign_key: { to_table: :users }
  end
end
