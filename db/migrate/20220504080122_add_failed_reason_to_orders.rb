class AddFailedReasonToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :failed_reason, :text
  end
end
