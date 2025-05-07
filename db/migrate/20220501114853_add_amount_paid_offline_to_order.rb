class AddAmountPaidOfflineToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :amount_paid_offline, :boolean, default: false
  end
end
