require_relative 'calendar'
require 'date'

module Hotel
  attr_reader :start_date, :end_date

  # Need to transform non-string dates?
  class Reservation
    def initialize start_date, end_date
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)

      #Catch invalid dates and date ranges
      if @start_date > @end_date
        raise ArgumentError, "End date cannot be before start date."
      end

      # need to first convert dates to x, y, z
      if Date.valid_date?(@start_date.year, @start_date.mon, @start_date.mday) == false || Date.valid_date?(@end_date.year, @end_date.mon, @end_date.mday) == false
        raise ArgumentError, "You must give valid dates."
      end
    end

    # Calculate time span of date ranges
    def duration
      (@end_date - @start_date)
    end

    def available_rooms
      @available_rooms = (1..20).to_a
    end
  end
end