class AddDeliveredCountToOrderItems < ActiveRecord::Migration[6.1]
  def change
    add_column :order_items, :delivered_count, :integer, default: 0
    add_column :products, :available_for_one_time_delivery, :boolean,  default: true
  end
end
