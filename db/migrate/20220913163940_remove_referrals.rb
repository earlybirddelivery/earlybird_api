class RemoveReferrals < ActiveRecord::Migration[6.0]
  def change
    drop_table :referrals
  end
end
