class AddOtpToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :otp, :integer
  end
end
