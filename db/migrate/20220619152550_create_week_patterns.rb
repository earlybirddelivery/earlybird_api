class CreateWeekPatterns < ActiveRecord::Migration[6.0]
  def change
    create_table :week_patterns do |t|
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.boolean :sunday
      t.references :selector, polymorphic: true
      t.timestamps
    end
  end
end
