class AddDescriptionToProd < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :description, :string
    add_column :products, :subscribable, :boolean, default: false
  end
end
