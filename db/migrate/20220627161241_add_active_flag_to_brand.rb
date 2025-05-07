class AddActiveFlagToBrand < ActiveRecord::Migration[6.0]
  def change
    add_column :brands, :active, :boolean, default: true
  end
end
