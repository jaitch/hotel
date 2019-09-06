require 'date'

module Hotel
  class Room

    attr_reader :number

    def initialize number
      @number = number
      @occupied_date_ranges = occupied_date_ranges
    end




  end
end


    # make 20 instances of this class. each class holds an array of date-ranges