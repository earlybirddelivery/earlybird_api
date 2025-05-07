class AddColumnSoftDeleteToAddressDetail < ActiveRecord::Migration[6.0]
  def change
    add_column :address_details, :deleted_at, :datetime
  end
end
