class AddPauseOrderItems < ActiveRecord::Migration[6.1]
  def change
    add_column :order_items, :pause_until, :date
    add_column :orders, :cancel_reason, :string
    add_column :orders, :issue_description, :string
  end
end
