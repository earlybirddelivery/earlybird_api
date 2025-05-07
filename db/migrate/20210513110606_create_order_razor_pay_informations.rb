class CreateOrderRazorPayInformations < ActiveRecord::Migration[6.0]
  def change
    create_table :order_razor_pay_informations do |t|
      t.references :order, foreign_key: true, null: false
      t.string :razor_pay_orderid, null: false
      t.string :entity
      t.integer :amount
      t.integer :amount_paid
      t.integer :amount_due
      t.string :currency
      t.string :receipt
      t.string :offer_id
      t.string :status
      t.integer :attempts
      t.string :notes, array: true, default: []
      t.bigint :razor_pay_created_at
      t.string :razorpay_payment_id
      t.string :razorpay_signature
      t.timestamps
    end
    add_column :orders, :razor_pay_orderid, :string
    add_column :orders, :razor_pay_amount, :integer
    add_column :orders, :razor_pay_status, :string
    add_column :orders, :razorpay_payment_id, :string
    add_column :orders, :razorpay_signature, :string
  end
end
