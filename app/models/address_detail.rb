class AddressDetail < ApplicationRecord
  has_one :location, dependent: :destroy
  belongs_to :addressable, polymorphic: true
  has_many :orders, dependent: :nullify
  scope :active, -> { where(deleted_at: nil) }
  scope :order_records, -> { order(primary: :desc, id: :desc) }

  accepts_nested_attributes_for :location, allow_destroy: true

  def self.filter(customer)
    customer.address_details.active.order_records
  end
end
