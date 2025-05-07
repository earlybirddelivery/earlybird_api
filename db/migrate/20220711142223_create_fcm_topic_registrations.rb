class CreateFcmTopicRegistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :fcm_topic_registrations do |t|
      t.references :fcm_topic, foreign_key: true
      t.references :fcm_registration_id, foreign_key: true
      t.timestamps
    end
  end
end
