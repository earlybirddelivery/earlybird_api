class RenameCustomerIdInCrmCustomerMappings < ActiveRecord::Migration[7.1]
  def change
    rename_column :crm_customer_mappings, :customers_id, :customer_id
  end
end
