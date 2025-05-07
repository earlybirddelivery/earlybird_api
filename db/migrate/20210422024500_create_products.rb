class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.boolean :boolean, default: true
      t.integer :priority
      t.references :brand, foreign_key: true
      t.timestamps
    end
  end
end
