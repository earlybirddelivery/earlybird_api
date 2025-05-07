class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.references :address_detail, foreign_key: true
      t.timestamps
    end
  end
end
