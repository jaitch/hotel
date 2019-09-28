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

    def is_available_on_date? date_sought
      if self.occupied_date_ranges.length == 0 && self.blocks.length == 0
        return true
      else
        self.occupied_date_ranges.each do |range|
          if ((range.start_date...range.end_date).include?(date_sought)) == false
            return true
          end
        end
        return false
      end
    end

    def is_available_for_date_range? date_range_object
      if self.occupied_date_ranges.length == 0 && self.blocks.length == 0
        return true
      else
        self.occupied_date_ranges.each do |range|
          if (range.overlap?(date_range_object)) == false
            return true
          end
        end
        return false
      end
    end
  end
end