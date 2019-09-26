require 'date'

module Hotel
  class DateRange
    attr_reader :start_date, :end_date

    def initialize start_date, end_date
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      validate_dates(@start_date, @end_date)
    end

    def validate_dates(start_date, end_date)
      if Date.valid_date?(start_date.year,start_date.mon,start_date.mday) == false || Date.valid_date?(end_date.year,end_date.mon,end_date.mday) == false
        raise ArgumentError, "You must give valid dates."
      end
      if start_date > end_date
        raise ArgumentError, "End date cannot be before start date."
      end
    end

    def duration
      (@end_date - @start_date).to_i
    end

    def overlap?(other_date_range)
      return self.end_date > other_date_range.start_date && other_date_range.start_date >= self.start_date || other_date_range.end_date > self.start_date && self.start_date >= other_date_range.start_date
    end
  end
end
