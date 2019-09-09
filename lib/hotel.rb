require_relative 'date_range'
require_relative 'room'
require 'date'

module Hotel
  class Hotel
    attr_reader  :num_rooms, :start_date, :end_date, :all_rooms, :available_rooms, :reservations

    def initialize num_rooms
      @num_rooms = num_rooms
      @all_rooms = (1..@num_rooms).map {|num| Room.new(num)}
    end

    def list_rooms(rooms_array)
      return rooms_array.map { |room| room.number }
    end

    def make_reservation(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      @pending_date_range = DateRange.new(start_date.to_s, end_date.to_s)

      validate_dates(@pending_date_range)

      if available_rooms_given_date_range(start_date, end_date).length > 0
        available_rooms[0].occupied_date_ranges << @pending_date_range
        return "Reservation booked. Amount due: $#{calculate_cost(@pending_date_range, rate = 200)}."
      elsif available_rooms_given_date_range(start_date, end_date).length == 0
        return "Sorry. No available rooms for that date."
      end
    end

    def make_room_block(num_rooms, start_date, end_date)
      @num_rooms = num_rooms
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      @pending_date_range = DateRange.new(start_date.to_s, end_date.to_s)

      if @num_rooms > 5
        return 'Sorry. Blocks have a maximum of five rooms.'
      end

      validate_dates(@pending_date_range)

      if available_rooms_given_date_range(start_date, end_date).length >= num_rooms
        (@available_rooms)[0...num_rooms].map {|room|room.blocks << @pending_date_range}
        return "We have set aside rooms #{list_rooms((@available_rooms)[0...num_rooms])} for you. They are available to reserve at a 20% discount."
      elsif available_rooms_given_date_range(start_date, end_date).length < num_rooms
        return "Sorry. We don't have that many rooms available for that date."
      end
    end

    def book_a_room_in_an_existing_block(room_num, start_date, end_date)
      @room_num = room_num
      date_range = DateRange.new(start_date, end_date)
      validate_dates(date_range)
      if all_rooms[room_num].blocks.include? (date_range)
        all_rooms[room_num].occupied_date_ranges << date_range
        all_rooms[room_num].blocks - date_range
        return "Reservation booked. Amount due: $#{calculate_cost(date_range, rate = 160)}."
      else
        return "Sorry. That room is not available at the block rate for those dates."
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

    # helper method for calculating cost
    def calculate_cost(pending_date_range, rate)
      amount_due = rate * pending_date_range.duration
      return amount_due
    end

    # I am assuming that someone might seek a date/look for available rooms for that date as a start date, but not as an end date. Therefore, I am including rooms that open up (that have reservations ending) on the date sought on the list of available rooms.
    def available_rooms_given_date(date_sought)
      @date_sought = Date.parse(date_sought)
      @available_rooms = []
      @all_rooms.each do |room|
        if room.occupied_date_ranges.length == 0 && room.blocks.length == 0
          @available_rooms << room
        else
          room.occupied_date_ranges.each do |range|
            @cur_range = Range.new(range.start_date, range.end_date-1)
            if (@cur_range.include? (@date_sought)) == false
              @available_rooms << room
            end
          end
          room.blocks.each do |range|
            @cur_range = Range.new(range.start_date, range.end_date-1)
            if (@cur_range.include? (@date_sought)) == true && @available != nil && @available[-1] == room
              @available.tap(&:pop)
            end
          end
        end
      end
      @available_rooms.uniq!
      return list_rooms(@available_rooms)
    end

    def available_rooms_given_date_range(start_date, end_date)
      @date_range_sought = DateRange.new(start_date, end_date)
      @available_rooms = []
      @all_rooms.each do |room|
        if room.occupied_date_ranges.length == 0 && room.blocks.length == 0
          @available_rooms << room
        else
          room.occupied_date_ranges.each do |range|
            if (range.overlap?(@date_range_sought)) == false
              @available_rooms << room
            end
          end
          room.blocks.each do |range|
            @cur_range = Range.new(range.start_date, range.end_date-1)
            if (range.overlap? (@date_range_sought)) == true && @available != nil && @available[-1] == room
              @available.tap(&:pop) if @available != nil
            end
          end
        end
      end
      @available_rooms.uniq!
      return list_rooms(@available_rooms)
    end

    # This method doesn't include rooms blocked; just for made reservations
    def list_reservations_given_date(date_sought)
      @date_sought = Date.parse(date_sought)
      @reservations = {}
      @all_rooms.each do |room|
        room.occupied_date_ranges.each do |range|
          @cur_range = Range.new(range.start_date, range.end_date)
          if (@cur_range.include? (@date_sought)) == true
            @reservations[range] = room.number
          end
        end
      end
      return @reservations
    end
  end
end
