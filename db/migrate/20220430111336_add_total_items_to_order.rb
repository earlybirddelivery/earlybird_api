class AddTotalItemsToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :total_items, :integer
  end
end
