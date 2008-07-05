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
    
    def unit(unit, options)
      unit = eval("Units::#{unit.to_s.capitalize}").new
      @level.add(unit, options[:x], options[:y], options[:facing])
      yield unit if block_given?
      unit
    end
    
    def warrior(options, &block)
      @level.warrior = unit(:warrior, options, &block)
    end
  end
end
