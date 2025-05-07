class AddUserStamps < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :created_by, :integer
    add_column :customers, :updated_by, :integer

    add_column :user_roles, :created_by, :integer
    add_column :user_roles, :updated_by, :integer
  end
end
