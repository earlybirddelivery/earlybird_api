class CreateProductVariantVersions < ActiveRecord::Migration[6.0]
  def change
    create_table :product_variant_versions do |t|
      t.references :product_variant, foreign_key: true
      t.decimal :price
      t.integer :version, default: 1
      t.timestamps
    end
  end
end
