class CreateOrderReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :order_reviews do |t|
      t.references :order, foreign_key: true
      t.integer :rating
      t.string :comment
      t.timestamps
    end
  end
end
