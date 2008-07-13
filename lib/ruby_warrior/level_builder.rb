module RubyWarrior
  class LevelBuilder
    def self.build(file, profile)
      unless file.nil?
        builder = new(profile)
        builder.instance_eval(File.read(file))
        builder.result
      end
    end
    
    def initialize(profile)
      @profile = profile
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
      @level.place_stairs(options[:x], options[:y])
    end
    
    def unit(unit, options)
      unit = eval("Units::#{unit.to_s.capitalize}").new unless unit.kind_of? Units::Base
      @level.add(unit, options[:x], options[:y], options[:facing])
      yield unit if block_given?
      unit
    end
    
    def warrior(options, &block)
      @level.warrior = unit(@profile.warrior, options, &block)
    end
  end
end
