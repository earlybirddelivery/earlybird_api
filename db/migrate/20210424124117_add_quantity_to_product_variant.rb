class AddQuantityToProductVariant < ActiveRecord::Migration[6.0]
  def change
    add_column :product_variants, :quantity, :string
  end
end
