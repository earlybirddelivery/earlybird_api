class Poster < ApplicationRecord
  has_one_attached :display_pic
  default_scope { order('display_order asc') }
  def display_pic_url
    return unless display_pic.attached?

    display_pic.url
  end
end
