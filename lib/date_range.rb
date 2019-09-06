require 'date'

module Hotel
  class DateRange
    attr_reader :start_date, :end_date

    def initialize start_date, end_date
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
    end

    # Calculate time span of date ranges
    def duration
      (@end_date - @start_date).to_i
    end

    def overlap?(other_date_range)
      if self.end_date < other_date_range.end_date
        return true
      elsif self.start_date < other_date_range.end_date
        return true
      elsif self.start_date == other_date_range.start_date || self.end_date == other_date_range.end_date
        return true
      elsif self.start_date > other_date_range.start_date && self.end_date < other_date_range.end_date
        return true
      elsif self.start_date < other_date_range.start_date && self.end_date > other_date_range.end_date
      end
      return false
    end
  end
end