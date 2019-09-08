require_relative 'date_range'
require_relative 'room'
require 'date'

module Hotel
  class Hotel
    attr_reader  :num_rooms, :start_date, :end_date, :all_rooms, :available_rooms

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

    def list_rooms(rooms_array)
      return rooms_array.map { |room| room.number }
    end

    def make_reservation(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      @pending_date_range = DateRange.new(start_date.to_s, end_date.to_s)

      validate_dates(@pending_date_range)

      if find_available_room(@all_rooms, @pending_date_range) == true
        return "Reservation booked. Amount due: $#{calculate_cost(@pending_date_range)}."
      elsif find_available_room(@all_rooms, @pending_date_range) == false
        return "Sorry. No available rooms for that date."
      end
    end

    # helper method for validation
    def validate_dates(pending_date_range)
      if Date.valid_date?(start_date.year,start_date.mon,start_date.mday) == false || Date.valid_date?(end_date.year,end_date.mon,end_date.mday) == false
        raise ArgumentError, "You must give valid dates."
      end

      if start_date > end_date
        raise ArgumentError, "End date cannot be before start date."
      end
    end

    # helper method for finding room
    def find_available_room(all_rooms, pending_date_range)
      all_rooms.each do |room|
        if room.occupied_date_ranges.length == 0
          room.occupied_date_ranges << pending_date_range
          return true
        end

        room.occupied_date_ranges.each do |date_range|
          if date_range.overlap?(@pending_date_range) == false
            room.occupied_date_ranges << @pending_date_range
            return true
          end
        end
      end
      return false
    end

    # helper method for calculating cost
    def calculate_cost(pending_date_range)
      rate = 200
      amount_due = rate * pending_date_range.duration
      return amount_due
    end

    def available_rooms_given_date(date_sought)
      @date_sought = Date.parse(date_sought)
      @available_rooms = []
      @all_rooms.each do |room|
        if room.occupied_date_ranges.length == 0
          @available_rooms << room
        else
          room.occupied_date_ranges.each do |range|
            @cur_range = Range.new(range.start_date, range.end_date)
            if ((@cur_range.include? (@date_sought)) == false)
              @available_rooms << room
            end
          end
        end
      end
      @available_rooms.uniq!
      return list_rooms(@available_rooms)
    end
  end
end
