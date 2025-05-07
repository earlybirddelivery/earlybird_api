class Referral < ApplicationRecord
  belongs_to :referrer, class_name: 'User'
  belongs_to :referred_user, class_name: 'User'
end
