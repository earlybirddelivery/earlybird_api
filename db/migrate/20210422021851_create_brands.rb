class CreateBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :brands do |t|
      t.string :name
      t.references :category, foreign_key: true
      t.integer :discount
      t.integer :priority
      t.timestamps
    end
  end
end
