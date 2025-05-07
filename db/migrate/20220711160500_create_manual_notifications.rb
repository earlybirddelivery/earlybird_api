class CreateManualNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :manual_notifications do |t|
      t.string :title
      t.string :message
      t.references :fcm_topic, foreign_key: true
      t.timestamps
    end
  end
end
