class AddUserConfirmationColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :otp_expiry_time, :datetime
    add_column :users, :confirmed, :boolean
  end
end
