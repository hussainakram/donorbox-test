# frozen_string_literal: true
module DateTimeHelpers
  def date_range_of(date)
    day = Time.parse(date)
    [day.beginning_of_day..day.end_of_day]
  rescue StandardError
    nil
  end
end
