class AddProductRelatedColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :out_of_stock, :boolean, default: false
    add_column :products, :coming_soon, :boolean, default: false
  end
end
