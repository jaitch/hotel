require_relative 'date_range'
require_relative 'room'
require 'date'

module Hotel
  class Hotel
    attr_reader  :num_rooms, :start_date, :end_date, :all_rooms

    def initialize num_rooms
      @num_rooms = num_rooms
    end

    def make_rooms_array
      all_rooms = []
      room_num = 1
      @num_rooms.times do
        all_rooms << Room.new(room_num)
        room_num += 1
      end
      return all_rooms
    end

    def make_reservation(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)

      if Date.valid_date?(@start_date.year,@start_date.mon,@start_date.mday) == false || Date.valid_date?(@end_date.year,@end_date.mon,@end_date.mday) == false
        raise ArgumentError, "You must give valid dates."
      end

      if @start_date > @end_date
        raise ArgumentError, "End date cannot be before start date."
      end
      return true
    end


    #def make_reservation
      # find room that's available for that span
      # add these dates to that room's array of taken dates
      # calculate the cost of this reservation
      # return room number and cost

      # method to search for reservation by start date

      # def available_rooms
      #   @available_rooms = (1..20).to_a
      # end

      # make sure one start date isn't before another's end date. can be same day.
    #end
  end
end