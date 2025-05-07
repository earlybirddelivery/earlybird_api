class AddOrderIdColumnToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :orderid, :string
    add_index :orders, :orderid
  end
end
