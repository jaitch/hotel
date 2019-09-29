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
      if self.occupied_date_ranges.length == 0
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

    def is_within_a_block? date_sought
      if self.blocks.length == 0
        return false
      else
        self.blocks.each do |block|
          if ((block.start_date...block.end_date).include?(date_sought)) == true
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
          if (range.overlap?(date_range_object))
            return false
          end
          self.blocks.each do |block|
            if (block.overlap?(date_range_object))
              return false
            end
          end
        end
        return true
      end
    end

    def rooms_in_given_block date_range_object
      block.start_date == date_range_object.start_date && block.end_date == date_range_object.end_date
    end
  end
end
