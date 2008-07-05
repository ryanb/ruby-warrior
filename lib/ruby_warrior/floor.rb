module RubyWarrior
  class Floor
    attr_reader :units
    attr_accessor :width, :height, :grid
    
    def initialize(width, height)
      @width = width
      @height = height
      @units = []
    end
    
    def add(unit, x, y, direction = nil)
      @units << unit
      unit.position = Position.new(self, x, y, direction)
    end
    
    def get(x, y)
      @units.detect do |unit|
        unit.position.at?(x, y)
      end
    end
  end
end
