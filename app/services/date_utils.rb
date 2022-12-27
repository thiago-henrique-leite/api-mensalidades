# frozen_string_literal: true

module DateUtils
  class << self
    def allocate(day, installments)
      dates = []

      first_date = today.day < day ? today : today.next_month

      installments.times do |index|
        date = first_date.next_month(index)

        dates << build_date(date.year, date.month, day)
      end

      dates
    end

    private

    def build_date(year, month, day)
      Date.civil(year, month, day)
    rescue Date::Error
      Date.civil(year, month, -1)
    end

    def today
      Time.zone.today
    end
  end
end
