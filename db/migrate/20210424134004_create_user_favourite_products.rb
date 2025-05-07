class CreateUserFavouriteProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :user_favourite_products do |t|
      t.references :favourite_product, index: { name: :favourite_product }, null: false,
                                       foreign_key: { to_table: :products }
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
