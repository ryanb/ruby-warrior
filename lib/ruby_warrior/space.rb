module RubyWarrior
  class Space
    def initialize(floor, x, y)
      @floor, @x, @y = floor, x, y
    end
    
    def wall?
      @floor.out_of_bounds? @x, @y
    end
    
    def warrior?
      unit.kind_of? Units::Warrior
    end
    
    def enemy?
      unit && !warrior? && !captive?
    end
    
    def captive?
      unit.kind_of? Units::Captive
    end
    
    def empty?
      unit.nil? && !wall?
    end
    
    def stairs?
      @floor.stairs_location == [@x, @y]
    end
    
    def unit
      @floor.get(@x, @y)
    end
  end
end
