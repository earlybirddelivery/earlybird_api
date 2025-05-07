class DashboardTile < ApplicationRecord
  validates :name, uniqueness: true, presence: true

  def self.create_unless_found!(data, find_by_key)
    tile = DashboardTile.where("#{find_by_key} = ?", data[find_by_key.to_sym]).first
    return if tile

    DashboardTile.create!(data)
  end
end
