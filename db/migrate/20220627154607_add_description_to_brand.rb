class AddDescriptionToBrand < ActiveRecord::Migration[6.0]
  def change
    add_column :brands, :description, :text
  end
end
