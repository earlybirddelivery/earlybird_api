class DeliveryTask < ApplicationRecord
  auto_strip_attributes :status

  STATUS_OPTIONS = %w[Created Assigned Ongoing Completed Cancelled].freeze

  validates :status, inclusion: { in: STATUS_OPTIONS }

  belongs_to :delivery_boy
  belongs_to :dealer
  has_many :orders
end
