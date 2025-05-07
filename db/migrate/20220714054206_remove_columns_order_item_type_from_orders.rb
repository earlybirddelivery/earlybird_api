class RemoveColumnsOrderItemTypeFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :order_items, :order_item_type
  end
end
