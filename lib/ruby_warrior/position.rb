module RubyWarrior
  class Position
    DIRECTIONS = [:north, :east, :south, :west]
    
    def initialize(floor, x, y, direction = nil)
      @floor = floor
      @x = x
      @y = y
      @direction_index = DIRECTIONS.index(direction || :north)
    end
    
    def at?(x, y)
      @x == x && @y == y
    end
    
    def direction
      DIRECTIONS[@direction_index]
    end
    
    def rotate(amount)
      @direction_index += amount
      @direction_index -= 4 while @direction_index > 3
      @direction_index += 4 while @direction_index < 0
    end
    
    def relative_space(forward, right = 0)
      @floor.space(*translate_offset(forward, right))
    end
    
    def move(forward, right = 0)
      @x, @y = *translate_offset(forward, right)
    end
    
    def distance_from_stairs
      stairs_x, stairs_y = *@floor.stairs_location
      (@x - stairs_x).abs + (@y - stairs_y).abs
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
