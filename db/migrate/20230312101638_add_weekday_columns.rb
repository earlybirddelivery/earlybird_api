class AddWeekdayColumns < ActiveRecord::Migration[6.1]
  def change
    add_column :week_patterns, :week_days, :string, array: true, default: []
  end
end
