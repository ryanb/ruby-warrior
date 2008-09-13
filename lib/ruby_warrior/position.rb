module RubyWarrior
  class Position
    attr_reader :floor
    DIRECTIONS = [:north, :east, :south, :west]
    RELATIVE_DIRECTIONS = [:forward, :right, :backward, :left]
    
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
    
    def space
      @floor.space(@x, @y)
    end
    
    def move(forward, right = 0)
      @x, @y = *translate_offset(forward, right)
    end
    
    def distance_from_stairs
      stairs_x, stairs_y = *@floor.stairs_location
      (@x - stairs_x).abs + (@y - stairs_y).abs
    end
    
    def relative_direction_of_stairs
      relative_direction_of(@floor.stairs_space)
    end
    
    def relative_direction_of(space)
      relative_direction(direction_of(space))
    end
    
    def direction_of(space)
      space_x, space_y = *space.location
      if (@x - space_x).abs > (@y - space_y).abs
        space_x > @x ? :east : :west
      else
        space_y > @y ? :south : :north
      end
    end
    
    def relative_direction(direction)
      offset = DIRECTIONS.index(direction) - @direction_index
      offset -= 4 while offset > 3
      offset += 4 while offset < 0
      RELATIVE_DIRECTIONS[offset]
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
