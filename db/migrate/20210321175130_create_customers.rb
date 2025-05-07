class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :mobile_number, null: false
      t.string :email
      t.date :date_of_birth
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
