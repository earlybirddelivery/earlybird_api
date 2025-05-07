class CreateDayPatterns < ActiveRecord::Migration[6.0]
  def change
    create_table :day_patterns do |t|
      t.references :selector, polymorphic: true
      t.integer :days_gap
      t.timestamps
    end
  end
end
