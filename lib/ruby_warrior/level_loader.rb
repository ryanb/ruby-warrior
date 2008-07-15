module RubyWarrior
  class LevelLoader
    def initialize(level)
      @floor = RubyWarrior::Floor.new
      @level = level
      @level.floor = @floor
    end
    
    def description(desc)
      @level.description = desc
    end
    
    def tip(tip)
      @level.tip = tip
    end
    
    def size(width, height)
      @floor.width = width
      @floor.height = height
    end
    
    def stairs(x, y)
      @floor.place_stairs(x, y)
    end
    
    def unit(unit, x, y, facing = :north)
      unit = eval("Units::#{unit.to_s.capitalize}").new unless unit.kind_of? Units::Base
      @floor.add(unit, x, y, facing)
      yield unit if block_given?
      unit
    end
    
    def warrior(*args, &block)
      @level.setup_warrior unit(Units::Warrior.new, *args, &block)
    end
  end
end
