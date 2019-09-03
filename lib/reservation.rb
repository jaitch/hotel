module Hotel
  attr_reader :start_date, end_date

  class Reservation
    def initialize (start_date, end_date)
      @start_date = start_date
      @end_date = end_date
    end