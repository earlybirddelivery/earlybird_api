class AddNotificationKeyToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :notification_key_name, :string
    add_column :users, :notification_key, :string
  end
end
