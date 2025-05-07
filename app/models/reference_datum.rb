class ReferenceDatum < ApplicationRecord
  auto_strip_attributes :data_type, :key, :label

  KEY_SUPER_ADMIN = 'key_super_admin'.freeze
  KEY_ADMIN = 'key_admin'.freeze
  KEY_CUSTOMER = 'key_customer'.freeze
  KEY_DELIVERY_BOY = 'key_delivery_boy'.freeze
  KEY_CRM = 'key_crm'.freeze

  KEY_CUSTOMER_ACCESS = [KEY_SUPER_ADMIN, KEY_ADMIN, KEY_CUSTOMER, KEY_CRM].freeze
  KEY_ADMIN_ACCESS = [KEY_ADMIN, KEY_SUPER_ADMIN].freeze
  KEY_SUPER_ADMIN_ACCESS = [KEY_SUPER_ADMIN].freeze
  PRODUCT_SUPER_LIST_ACCESS = [KEY_SUPER_ADMIN].freeze

  validates :data_type, :key, :label, presence: true
  validates :active, inclusion: { in: [true, false] }
  validates :key, uniqueness: { case_sensitive: false }
  def self.create_unless_found!(data_type, key, label, sort_order = 1, short_key = '')
    return if ReferenceDatum.find_by(key: key)

    ReferenceDatum.create!(data_type: data_type, key: key, label: label, sort_order: sort_order, short_key: short_key)
  end

  def self.filter(data_type)
    ReferenceDatum.where(data_type: data_type)
  end

  def self.label_value(key)
    ReferenceDatum.where('key = ?', key).first.label
  end
end
