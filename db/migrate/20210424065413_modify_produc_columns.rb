class ModifyProducColumns < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :boolean, :active
  end
end
