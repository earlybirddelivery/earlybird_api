namespace :populate do
  task calendar: :environment do
    print Time.zone.now
    records = []
    (Date.new(2021, 1, 1)..Date.new(2050, 12, 31)).each do |date|
      records << Calendar.new(date: date, year: date.year, month: date.month, day_of_month: date.day,
                              day_of_week: date.strftime('%A').downcase, quarter: (date.month / 3) + 1)
    end
    Calendar.import(records)
    print Time.zone.now
  end

  task week_days: :environment do
    records = []
    WeekPattern.find_each do |week_pattern|
      week_days = []
      week_days << 'monday' if week_pattern.monday
      week_days << 'tuesday' if week_pattern.tuesday
      week_days << 'wednesday' if week_pattern.wednesday
      week_days << 'thursday' if week_pattern.thursday
      week_days << 'friday' if week_pattern.friday
      week_days << 'saturday' if week_pattern.saturday
      week_days << 'sunday' if week_pattern.sunday
      week_pattern.week_days = week_days
      records << week_pattern
    end
    WeekPattern.import(records, on_duplicate_key_update: [:week_days])
  end

  task subscription_type: :environment do
    subscription_types = %w[week_pattern day_pattern quantity_pattern]
    order_items = OrderItem.where.not(subscription_type: %w[week_pattern day_pattern quantity_pattern], subscription_start_date: nil)
  end
end
