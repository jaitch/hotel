module Hotel
  class Calendar
    attr_reader :end_date, :start_date



    # Calculate time span of date ranges
    def duration
      (reservation.end_date - reservation.start_date).to_i
    end
  end
end
