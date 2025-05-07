class CreateProductVariants < ActiveRecord::Migration[6.0]
  def change
    create_table :product_variants do |t|
      t.references :product, foreign_key: true
      t.string :variant_type
      t.decimal :price
      t.decimal :discount
      t.boolean :default
      t.timestamps
    end
  end
end
