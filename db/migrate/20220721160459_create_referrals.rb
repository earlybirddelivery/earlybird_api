class CreateReferrals < ActiveRecord::Migration[6.0]
  def change
    create_table :referrals do |t|
      t.string :referal_code
      t.references :referred_user, index: { name: :referred_user }, null: false, foreign_key: { to_table: :users }
      t.references :referrer, index: { name: :referrer }, null: false, foreign_key: { to_table: :users }
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end
  end
end
