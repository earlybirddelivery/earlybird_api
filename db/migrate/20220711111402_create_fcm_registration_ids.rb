class CreateFcmRegistrationIds < ActiveRecord::Migration[6.0]
  def change
    create_table :fcm_registration_ids do |t|
      t.references :user, foreign_key: true
      t.string :registration_id
      t.string :device_name
      t.timestamps
    end
  end
end
