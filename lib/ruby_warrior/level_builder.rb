module RubyWarrior
  class LevelBuilder
    def initialize(level)
      @level = level
    end
    
    def size(width, height)
      @level.set_size(width, height)
    end
    
    def description(desc)
      @level.description = desc
    end
    
    def tip(tip)
      @level.tip = tip
    end
    
    def stairs(x, y)
      @level.place_stairs(x, y)
    end
    
    def unit(unit, x, y, facing = :north)
      unit = eval("Units::#{unit.to_s.capitalize}").new unless unit.kind_of? Units::Base
      @level.add(unit, x, y, facing)
      yield unit if block_given?
      unit
    end
    
    def warrior(*args, &block)
      @level.warrior = unit(Units::Warrior.new(@level.profile), *args, &block)
    end
  end
end
