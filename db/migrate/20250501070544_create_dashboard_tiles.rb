class CreateDashboardTiles < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_tiles do |t|
      t.string :name, null: false, index: true
      t.string :page_name, null: false
      t.boolean :active, default: false
      t.timestamps
    end
  end
end
