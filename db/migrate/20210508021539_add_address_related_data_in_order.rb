class AddAddressRelatedDataInOrder < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :address_detail, foreign_key: true
  end
end
