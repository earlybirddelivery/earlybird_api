class CreateCalendars < ActiveRecord::Migration[6.1]
  def change
    create_table :calendars do |t|
      t.integer :year, null: false
      t.integer :month, null: false
      t.integer :day_of_month, null: false
      t.string :day_of_week, null: false
      t.integer :quarter, null: false
      t.date :date, null: false
      t.timestamps
    end
  end
end
