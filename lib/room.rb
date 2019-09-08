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
