class ModifyColumnNameInOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :amount_paid, :integer
    rename_column :orders, :razor_pay_orderid, :razorpay_order_id
    rename_column :order_razor_pay_informations, :razor_pay_orderid, :razorpay_order_id
  end
end
