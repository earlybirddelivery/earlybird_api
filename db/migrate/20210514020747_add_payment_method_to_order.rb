class AddPaymentMethodToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :payment_method, :string
    add_column :orders, :gst, :integer
  end
end
