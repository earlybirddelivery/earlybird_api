class CreatePublishedNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :published_notifications do |t|
      t.references :manual_notification, foreign_key: true
      t.references :fcm_topic, foreign_key: true
      t.string :response_body
      t.integer :response_code
      t.integer :registration_ids, default: []
      t.references :user, foreign_key: true
      t.date :published_date
      t.time :published_time
      t.timestamps
    end
  end
end
