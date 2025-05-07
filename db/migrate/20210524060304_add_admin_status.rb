class AddAdminStatus < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :admin_status, :string
    add_column :orders, :packed, :boolean, default: false
  end
end
