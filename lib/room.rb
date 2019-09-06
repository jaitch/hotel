require 'date'

module Hotel
  class Room

    attr_reader :number
    attr_accessor :occupied_date_ranges

    def initialize number
      @number = number
      @occupied_date_ranges = []
    end





  end
end


    # make 20 instances of this class. each class holds an array of date-ranges