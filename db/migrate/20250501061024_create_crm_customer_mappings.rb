class CreateCrmCustomerMappings < ActiveRecord::Migration[7.1]
  def change
    create_table :crm_customer_mappings do |t|
      t.references :crm, index: { name: :crm }, null: false, foreign_key: { to_table: :users }
      t.references :customers, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.boolean :active, default: false
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end
  end
end
