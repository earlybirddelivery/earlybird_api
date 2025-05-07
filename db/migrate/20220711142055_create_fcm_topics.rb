class CreateFcmTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :fcm_topics do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.timestamps
    end
  end
end
