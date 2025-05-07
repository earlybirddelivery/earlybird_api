class CreateRazorpayPayments < ActiveRecord::Migration[6.0]
  def change
    create_table :razorpay_payments do |t|
      t.references :order_razor_pay_information, foreign_key: true
      t.string :payment_id
      t.string :entity
      t.integer :amount
      t.string :currency
      t.string :payment_status
      t.string :invoice_id
      t.boolean :international
      t.string :method
      t.integer :amount_refunded
      t.string :refund_status
      t.boolean :captured
      t.string :description
      t.string :card_id
      t.string :bank
      t.string :wallet
      t.string :vpa
      t.string :email
      t.string :contact
      t.string :notes, array: true
      t.integer :fee
      t.integer :tax
      t.string :error_code
      t.string :error_description
      t.string :error_source
      t.string :error_step
      t.string :error_reason
      t.json :acquirer_data
      t.string :payment_initiated_at
      t.timestamps
    end
  end
end
