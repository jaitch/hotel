require 'date'

module Hotel
  class Room

    attr_reader :number
    attr_accessor :occupied_date_ranges, :blocks

    def initialize number
      @number = number
      @occupied_date_ranges = []
      @blocks = []
    end


  end
end
