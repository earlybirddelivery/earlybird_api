class CrmCustomerMapping < ApplicationRecord
  belongs_to :crm, class_name: 'User',
                   inverse_of: :crm_customer_mappings, optional: true
  belongs_to :customer
end
