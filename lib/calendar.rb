require 'date'

module Hotel
  class Calendar
    attr_reader :end_date, :start_date

    # Calculate time span of date ranges
    def duration
      (Reservation.end_date - Reservation.start_date)
    end

    # def available_rooms
    #   @available_rooms = (1..20).to_a
    # end

    # Store an array of reserved dates in each room
    def reservations_by_date(date)
      @all_rooms = (1..20).to_a
      @available_rooms = []
      @unavailabe_rooms = []
      @all_rooms.each |room| {
        room.include(date) ? unavailabe_rooms << room : @available_rooms << room

    end

  end
end
