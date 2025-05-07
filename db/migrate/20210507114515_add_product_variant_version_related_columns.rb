class AddProductVariantVersionRelatedColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :product_variants, :current_product_variant_version, :integer
    add_reference :order_items, :product_variant_version, foreign_key: true
  end
end
