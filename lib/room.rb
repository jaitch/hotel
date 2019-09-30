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
      if @occupied_date_ranges.length == 0
        return true
      else
        @occupied_date_ranges.each do |range|
          if ((range.start_date...range.end_date).include?(date_sought)) == false
            return true
          end
        end
        return false
      end
    end

    def is_within_a_block? date_sought
      date_sought = Date.parse(date_sought.to_s)
      if @blocks.length == 0
        return false
      else
        @blocks.each do |block|
          if ((block.start_date...block.end_date).include?(date_sought)) == true
            return true
          end
        end
        return false
      end
    end

    def is_available_for_date_range? date_range_object
      if @occupied_date_ranges.length == 0 && @blocks.length == 0
        return true
      else
        @occupied_date_ranges.each do |range|
          if (range.overlap?(date_range_object))
            return false
          end
        end
        @blocks.each do |block|
          if (block.overlap?(date_range_object))
            return false
          end
        end
        return true
      end
    end

    def in_given_block? date_range_object
      @blocks.each do |block|
        if block.start_date == date_range_object.start_date && block.end_date == date_range_object.end_date
          return true
        end
      end
      return false
    end

    def add_to_blocks date_range_object
      @blocks << date_range_object
    end

    def add_to_occupied_date_ranges date_range_object
      @occupied_date_ranges << date_range_object
    end
  end
end
