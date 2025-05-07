class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.references :customer, foreign_key: true
      t.decimal :total_price
      t.timestamps
    end
    create_table :cart_items do |t|
      t.references :cart, foreign_key: true
      t.references :product, foreign_key: true
      t.references :product_variant, foreign_key: true
      t.references :product_variant_version, foreign_key: true
      t.timestamps
    end
  end
end
