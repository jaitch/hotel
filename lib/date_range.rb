require 'date'

module Hotel
  class Date_Range
    attr_reader :start_date, :end_date
    
    def initialize start_date, end_date
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
    end
    
    # Calculate time span of date ranges
    def duration
      (@end_date - @start_date).to_i
    end
    
    # def available_rooms
    #   @available_rooms = (1..20).to_a
    # end
    
    # Store an array of reserved dates in each room
    # def reservations_by_date(date)
    #   @all_rooms = (1..20).to_a
    #   @available_rooms = []
    #   @unavailabe_rooms = []
    #   @all_rooms.each do |room|
    #     if room.include?(date)
    #       @unavailabe_rooms << room
    #     else
    #       @available_rooms << room
    #     end
    #   end
    
  end
end