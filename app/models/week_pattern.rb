class WeekPattern < ApplicationRecord
  before_create :set_weekdays

  private

  def set_weekdays
    week_days = []
    week_days << 'monday' if monday
    week_days << 'tuesday' if tuesday
    week_days << 'wednesday' if wednesday
    week_days << 'thursday' if thursday
    week_days << 'friday' if friday
    week_days << 'saturday' if saturday
    week_days << 'sunday' if sunday
    self.week_days = week_days
  end
end
