class AddColumnPrimaryToAddressDetail < ActiveRecord::Migration[6.0]
  def change
    add_column :address_details, :primary, :boolean, default: false
  end
end
