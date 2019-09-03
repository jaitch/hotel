require_relative 'calendar'

module Hotel
  attr_reader :start_date, :end_date

  class Reservation
    def initialize start_date, end_date
      @start_date = start_date
      @end_date = end_date

    # Catch invalid dates and date ranges
    # if @start_date.class == String
    #   @start_date = Date.parse(@start_date)
    # end
    # if @end_date.class == String
    #   @end_date == Date.parse(@end_date)
    # end
    # if @start_date > @end_date
    #   raise ArgumentError, "End date cannot be before start date."
    # end
    # if @start_date.valid_date? == false || @end_date.valid_date? == false
    #   raise ArgumentError, "You must give valid dates."
    # end
  end

    def available_rooms
      @available_rooms = (1..20).to_a
    end
  end
end