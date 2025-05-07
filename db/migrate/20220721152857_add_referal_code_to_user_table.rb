class AddReferalCodeToUserTable < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :referal_code, :string
  end
end
