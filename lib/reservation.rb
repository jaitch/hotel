module Hotel
  class Reservation
    def initialize date_range_object
      @date_range_object = date_range_object
    end

    def calculate_cost(date_range_object, rate)
      amount_due = rate * date_range_object.duration
      return amount_due
    end
  end
end