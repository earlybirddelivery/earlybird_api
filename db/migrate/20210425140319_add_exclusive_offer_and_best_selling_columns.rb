class AddExclusiveOfferAndBestSellingColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :best_selling, :boolean
    add_column :products, :in_exclusive_offer, :boolean
  end
end
