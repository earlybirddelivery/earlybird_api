class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.boolean :active, default: true
      t.integer :priority
      t.timestamps
    end
  end
end
