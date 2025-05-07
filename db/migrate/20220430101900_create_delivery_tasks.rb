class CreateDeliveryTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_tasks do |t|
      t.references :delivery_boy, foreign_key: true
      t.decimal :total_bill, default: 0
      t.string :shift
      t.datetime :start_time
      t.datetime :end_time
      t.string :area
      t.timestamps
    end
  end
end
