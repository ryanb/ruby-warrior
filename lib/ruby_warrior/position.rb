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
    
    def get_relative(forward, right = 0)
      @floor.get(*translate_offset(forward, right))
    end
    
    def move(forward, right = 0)
      obj = @floor.clear(@x, @y)
      @x, @y = *translate_offset(forward, right)
      @floor.set(obj, @x, @y)
    end
    
    private
    
    def translate_offset(forward, right)
      case direction
      when :north then [@x + right, @y - forward]
      when :east then [@x + forward, @y + right]
      when :south then [@x - right, @y + forward]
      when :west then [@x - forward, @y - right]
      end
    end
  end
end
