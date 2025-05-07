class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true
      t.references :product_variant, foreign_key: true
      t.integer :count, default: 1
      t.decimal :price
      t.timestamps
    end
  end
end
