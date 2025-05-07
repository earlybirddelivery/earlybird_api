class RemoveUserIdFromCustomer < ActiveRecord::Migration[6.0]
  def change
    remove_column :customers, :user_id
  end
end
