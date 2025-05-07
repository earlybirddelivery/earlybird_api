class AddCurrentVersionIdToProductVersion < ActiveRecord::Migration[6.0]
  def change
    add_reference :product_variants, :current_product_variant_version,
                  foreign_key: { to_table: :product_variant_versions }
  end
end
