class AddProductVariantRelatedColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :product_variant_versions, :discount, :decimal, default: 0.0
    add_column :product_variant_versions, :final_price, :decimal
    add_column :product_variants, :final_price, :decimal
  end
end
