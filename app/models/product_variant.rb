class ProductVariant < ApplicationRecord
  validates :variant_type, ref_data_short_key: { data_type: 'variant_type' }

  before_validation :populate_final_price

  has_many :product_variant_versions

  after_commit :setup_version

  scope :order_records, -> { reorder(default: :desc) }

  accepts_nested_attributes_for :product_variant_versions, allow_destroy: true

  def populate_final_price
    self.final_price = discount ? price - ((discount * price) / 100) : price
  end

  def current_version
    product_variant_versions.find_by(version: current_product_variant_version)
  end

  private

  def setup_version
    return unless price_previously_changed? || discount_previously_changed? || final_price_previously_changed?

    pvv = product_variant_versions.create!(price: price, version: product_variant_versions.count + 1, discount: discount,
                                           final_price: final_price, created_by: created_by
    )
    update_columns(current_product_variant_version: pvv.version, current_product_variant_version_id: pvv.id)
  end
end
