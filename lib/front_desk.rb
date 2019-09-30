require_relative 'date_range'
require_relative 'room'
require_relative 'reservation'
require 'date'

module Hotel
  class FrontDesk
    attr_reader  :num_rooms, :start_date, :end_date, :all_rooms, :available_rooms, :reservations

    def initialize num_rooms
      @num_rooms = num_rooms
      @all_rooms = (1..@num_rooms).map {|num| Room.new(num)}
    end

    def list_rooms(rooms_array)
      return rooms_array.map { |room| room.number }
    end

    def make_reservation(date_range_object)
      @all_rooms.each do |room|
        if room.is_available_for_date_range?(date_range_object) && room.is_within_a_block?(date_range_object) == false
          room.add_to_occupied_date_ranges(date_range_object)
          reservation = Hotel::Reservation.new(date_range_object)
          return "Reservation booked. Amount due: $#{reservation.calculate_cost(date_range_object, 200)}."
        end
      end
      raise ArgumentError, 'Not available. Sorry.'
    end

    def make_room_block(num_rooms, date_range_object)
      if num_rooms > 5
        return 'Sorry. Blocks have a maximum of five rooms.'
      end
      available_rooms_array = available_rooms_given_date_range(date_range_object)
      if num_rooms <= available_rooms_array.length
        available_rooms_array[0...num_rooms].each do |room|
          room.add_to_blocks(date_range_object)
        end
        return "We have set aside rooms #{list_rooms((available_rooms_array)[0...num_rooms])} for you. They are available to reserve at a 20% discount."
      elsif available_rooms_array.length < num_rooms
        raise ArgumentError, "Sorry. We don't have that many rooms available for that date."
      end
    end

    def rooms_available_in_an_existing_block(date_range_object)
      return @all_rooms.select { |room| room.in_given_block?(date_range_object)}.map {|room| room.number}

    end

    def book_a_room_in_an_existing_block(room_num, date_range_object)
      room_index = room_num-1
      @all_rooms[room_index].blocks.each do |block|
        if block.start_date == date_range_object.start_date && block.end_date == date_range_object.end_date
          @all_rooms[room_index].occupied_date_ranges << date_range_object
          @all_rooms[room_index].blocks.delete(block)
          reservation = Hotel::Reservation.new(date_range_object)
          return "Reservation booked. Amount due: $#{reservation.calculate_cost(date_range_object, 160)}."
        end
      end
      return "Sorry. That room is not available at the block rate for those dates."
    end

    def calculate_cost(date_range_object, rate)
      return rate * date_range_object.duration
    end

    def available_rooms_given_date(date_sought)
      @all_rooms.select { |room| room.is_available_on_date?(date_sought) && (room.is_within_a_block?(date_sought) == false)
      }
    end

    def list_reservations_given_date(date_sought)
      p @all_rooms.select { |room| room.is_available_on_date?(date_sought) == false
      }.map { |room| room.number}
    end

    def available_rooms_given_date_range(date_range_object)
      @all_rooms.select { |room| room.is_available_for_date_range?(date_range_object)
      }
    end
  end
end