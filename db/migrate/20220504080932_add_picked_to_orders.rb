class AddPickedToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :picked, :boolean, default: false
  end
end
