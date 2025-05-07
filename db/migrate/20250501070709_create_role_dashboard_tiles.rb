class CreateRoleDashboardTiles < ActiveRecord::Migration[7.1]
  def change
    create_table :role_dashboard_tiles do |t|
      t.references :dashboard_tile, foreign_key: true
      t.string :role, null: false
      t.integer :created_by
      t.integer :updated_by
      t.integer :order
      t.timestamps
    end
  end
end
