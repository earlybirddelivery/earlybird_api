class AddColumnsToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :cgst, :integer
    add_column :orders, :sgst, :integer
    add_column :orders, :bill, :decimal
    rename_column :orders, :total_price, :total_bill
    add_column :orders, :delivery_fee, :decimal
  end
end
