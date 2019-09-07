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
      # if find_available_room(@all_rooms, @start_date, @end_date) == true
      # elsif find_available_room(@all_rooms, @start_date, @end_date) == false
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
      other_date_range = DateRange.new(start_date.to_s, end_date.to_s)
      all_rooms.each do |room|
        if room.occupied_date_ranges.length == 0
          room.occupied_date_ranges << other_date_range
          return true
        end

        room.occupied_date_ranges.each do |date_range|
          if date_range.overlap?(other_date_range) == false
            room.occupied_date_ranges << other_date_range
            return true
          end
        end
      end
      return false
    end
  end

end

# calculate the cost of this reservation
# return room number and cost

# method to search for reservation by start date

