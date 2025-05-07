class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :delivery_boy, foreign_key: true
      t.references :customer, foreign_key: true
      t.string :status
      t.string :area
      t.timestamps
    end
  end
end
