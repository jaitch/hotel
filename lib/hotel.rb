require_relative 'date_range'
require_relative 'room'
require 'date'

module Hotel
  class Hotel
    attr_reader  :num_rooms, :start_date, :end_date, :all_rooms

    def initialize num_rooms
      @num_rooms = num_rooms

      make_rooms_array
    end

    def make_rooms_array
      @all_rooms = []
      room_num = 1
      @num_rooms.times do
        all_rooms << Room.new(room_num)
        room_num += 1
      end
    end

    def make_reservation(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)

      validate_dates(@start_date, @end_date)
      find_available_room(@all_rooms, @start_date, @end_date)
    end

    # helper method for validation
    def validate_dates(start_date, end_date)
      if Date.valid_date?(start_date.year,start_date.mon,start_date.mday) == false || Date.valid_date?(end_date.year,end_date.mon,end_date.mday) == false
        raise ArgumentError, "You must give valid dates."
      end

      if start_date > end_date
        raise ArgumentError, "End date cannot be before start date."
      end
    end

    # helper method for finding room
    def find_available_room(all_rooms, start_date, end_date)
      all_rooms.each do |room|
        if room.occupied_date_ranges.length == 0
          return true
        else
          room.occupied_date_ranges.each do |date_range|
            if date_range.overlap?(start_date, end_date) == false
              return true
            end
          end
        end
      end
    end

  end
end
# all_rooms.each do |room|
#   if room.empty?

#     return true
#   end



# find room that's available for that span
# add these dates to that room's array of taken dates
# calculate the cost of this reservation
# return room number and cost

# method to search for reservation by start date

