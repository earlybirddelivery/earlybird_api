class AddClickActionToNotification < ActiveRecord::Migration[6.0]
  def change
    add_column :manual_notifications, :click_action, :string
  end
end
