module RubyWarrior
  class LevelBuilder
    def self.build(file)
      builder = new
      builder.instance_eval(File.read(file))
      builder.result
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
    
    def warrior(options)
      @level.add(Warrior.new, options[:x], options[:y], options[:facing])
    end
  end
end
