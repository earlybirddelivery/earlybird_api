class AddDisplayOrderToReferenceDataum < ActiveRecord::Migration[6.0]
  def change
    add_column :reference_data, :sort_order, :integer, default: 1
  end
end
