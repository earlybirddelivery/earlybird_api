class CreateQuantityPatterns < ActiveRecord::Migration[6.0]
  def change
    create_table :quantity_patterns do |t|
      t.references :selector, polymorphic: true
      t.integer :day1_quantity
      t.integer :day2_quantity
      t.integer :day3_quantity
      t.integer :day4_quantity
      t.timestamps
    end
  end
end
