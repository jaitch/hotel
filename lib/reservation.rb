module Hotel
  attr_reader :start_date, end_date

  class Reservation
    def initialize (start_date, end_date)
      @start_date = start_date
      @end_date = end_date
    end

    def available_rooms
      available_rooms = (1..20.to_a)
    puts available_rooms
    end