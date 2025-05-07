class AddTaskIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :delivery_task, foreign_key: true
  end
end
