class CreateVariants < ActiveRecord::Migration[6.0]
  def change
    create_table :variants do |t|
      t.string :variant_type
      t.integer :quantity
      t.timestamps
    end
  end
end
