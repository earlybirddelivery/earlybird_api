class RemoveUserIdFromDeliveryBoy < ActiveRecord::Migration[6.0]
  def change
    remove_index :delivery_boys, name: 'index_delivery_boys_on_user_id'
    remove_column :delivery_boys, :user_id
  end
end
