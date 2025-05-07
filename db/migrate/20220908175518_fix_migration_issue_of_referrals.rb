class FixMigrationIssueOfReferrals < ActiveRecord::Migration[6.0]
  def change
    def up
      drop_table :referrals
      create_table :referrals do |t|
        t.string :referal_code
        t.references :referred_user, index: { name: :referred_user }, null: false, foreign_key: { to_table: :users }
        t.references :referrer, index: { name: :referrer }, null: false, foreign_key: { to_table: :users }
        t.integer :created_by
        t.integer :updated_by
        t.timestamps
      end
    end

    def down
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
end
