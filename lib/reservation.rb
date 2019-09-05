require_relative 'calendar'
require 'date'

module Hotel
  attr_reader :start_date, :end_date

  # Need to transform non-string dates?
  class Reservation
    def initialize start_date, end_date
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)

      if Date.valid_date?(@start_date.year,@start_date.mon,@start_date.mday) == false || Date.valid_date?(@end_date.year,@end_date.mon,@end_date.mday) == false
        raise ArgumentError, "You must give valid dates."
      end

        #Catch invalid dates and date ranges
        if @start_date > @end_date
          raise ArgumentError, "End date cannot be before start date."
        end
    end

    def make_reservation
      # find room that's available for that span
      # add these dates to that room's array of taken dates
      # calculate the cost of this reservation
      # return room number and cost

# method to search for reservation by start date

    # def available_rooms
    #   @available_rooms = (1..20).to_a
    # end
  end
end