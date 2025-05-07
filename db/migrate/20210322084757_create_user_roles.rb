class CreateUserRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_roles do |t|
      t.references :user, foreign_key: true
      t.string :role, null: false
      t.timestamps
    end
  end
end
