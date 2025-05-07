class AddAdminColumnsToPv < ActiveRecord::Migration[6.1]
  def change
    add_column :product_variants, :active, :boolean, default: false
    add_column :product_variants, :stock, :integer
    add_column :product_variants, :out_of_stock, :integer

    add_column :product_variants, :deleted_at, :datetime
    add_column :product_variants, :deleted_by_id, :integer, index: true

    add_column :products, :deleted_at, :datetime
    add_column :products, :deleted_by_id, :integer, index: true

    add_column :brands, :deleted_at, :datetime
    add_column :brands, :deleted_by_id, :integer, index: true

  end
end
