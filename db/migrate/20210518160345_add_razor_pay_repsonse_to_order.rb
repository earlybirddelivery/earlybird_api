class AddRazorPayRepsonseToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :razor_pay_repsonse, :json
  end
end
