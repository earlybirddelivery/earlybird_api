class AddPaymentNotesToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :payment_notes, :text
  end
end
