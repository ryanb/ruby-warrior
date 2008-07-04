module RubyWarrior
  class Position
    DIRECTIONS = [:north, :east, :south, :west]
    
    def initialize(floor, x, y, direction)
      @floor = floor
      @x = x
      @y = y
      @direction_index = DIRECTIONS.index(direction)
    end
    
    def direction
      DIRECTIONS[@direction_index]
    end
    
    def rotate(amount)
      @direction_index += amount
      @direction_index -= 4 while @direction_index > 3
      @direction_index += 4 while @direction_index < 0
    end
  end
end
