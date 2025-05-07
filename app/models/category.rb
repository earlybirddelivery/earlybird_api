class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_one_attached :display_pic, dependent: :destroy
  has_many :brands, dependent: :destroy
  def display_pic_url
    return unless display_pic.attached?

    display_pic.url
  end
end
