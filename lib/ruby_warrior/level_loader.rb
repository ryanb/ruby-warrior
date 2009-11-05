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
    
    def clue(clue)
      @level.clue = clue
    end
    
    def time_bonus(bonus)
      @level.time_bonus = bonus
    end
    
    def ace_score(score)
      @level.ace_score = score
    end
    
    def size(width, height)
      @floor.width = width
      @floor.height = height
    end
    
    def stairs(x, y)
      @floor.place_stairs(x, y)
    end
    
    def unit(unit, x, y, facing = :north)
      unit = unit_to_constant(unit).new unless unit.kind_of? Units::Base
      @floor.add(unit, x, y, facing)
      yield unit if block_given?
      unit
    end
    
    def warrior(*args, &block)
      @level.setup_warrior unit(Units::Warrior.new, *args, &block)
    end
    
    private
    
    def unit_to_constant(name)
      camel = name.to_s.split('_').map { |s| s.capitalize }.join
      eval("Units::#{camel}")
    end
  end
end
