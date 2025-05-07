class CreateReferenceData < ActiveRecord::Migration[6.0]
  def change
    create_table :reference_data do |t|
      t.string :data_type, null: false, index: true
      t.string :key, null: false
      t.string :label, null: false
      t.boolean :active, null: false, default: true

      t.timestamps
    end

    add_index :reference_data, :key, unique: true
  end
end
