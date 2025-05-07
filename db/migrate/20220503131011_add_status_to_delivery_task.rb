class AddStatusToDeliveryTask < ActiveRecord::Migration[6.0]
  def change
    add_column :delivery_tasks, :status, :string, default: 'Created'
  end
end
