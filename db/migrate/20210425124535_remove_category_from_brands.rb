class RemoveCategoryFromBrands < ActiveRecord::Migration[6.0]
  def change
    remove_index :brands, name: 'index_brands_on_category_id'
    remove_column :brands, :category_id, :integer
    add_column :brands, :category_type, :string
  end
end
