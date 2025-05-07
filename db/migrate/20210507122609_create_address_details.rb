class CreateAddressDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :address_details do |t|
      t.string :full_name
      t.string :door_no
      t.string :mobile_number
      t.string :delivery_line_1
      t.string :delivery_line_2
      t.string :area
      t.string :city
      t.string :district
      t.string :state
      t.integer :pincode
      t.string :land_mark
      t.string :address_type
      t.references :addressable, polymorphic: true
      t.timestamps
    end
  end
end
