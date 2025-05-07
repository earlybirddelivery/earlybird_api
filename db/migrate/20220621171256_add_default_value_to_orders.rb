class AddDefaultValueToOrders < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:orders, :status, 'Created')
    change_column_default(:orders, :admin_status, 'Created')
  end
end
