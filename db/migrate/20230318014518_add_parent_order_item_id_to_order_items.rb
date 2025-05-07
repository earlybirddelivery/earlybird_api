class AddParentOrderItemIdToOrderItems < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :parent, foreign_key: { to_table: :orders }
  end
end
