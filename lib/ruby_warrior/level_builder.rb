module RubyWarrior
  class LevelBuilder
    def initialize
    end
    
    def level(number, options)
      @level = Level.new(number, options[:width], options[:height])
    end
    
    def description(desc)
      @level.description = desc
    end
    
    def tip(tip)
      @level.tip = tip
    end
    
    def result
      @level
    end
    
    def stairs(options)
      @level.goal = [options[:x], options[:y]]
    end
  end
end
