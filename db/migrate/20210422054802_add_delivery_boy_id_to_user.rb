class AddDeliveryBoyIdToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :delivery_boy, foreign_key: true
  end
end
