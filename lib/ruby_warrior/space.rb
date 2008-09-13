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
      unit && unit.bound?
    end
    
    def empty?
      unit.nil? && !wall?
    end
    
    def stairs?
      @floor.stairs_location == location
    end
    
    def ticking?
      unit.respond_to?(:bomb_time) && unit.bomb_time
    end
    
    def unit
      @floor.get(@x, @y)
    end
    
    def location
      [@x, @y]
    end
    
    def to_map
      if unit
        unit.to_map
      elsif stairs?
        ">"
      else
        " "
      end
    end
    
    def to_s
      if unit
        unit.to_s
      elsif wall?
        'wall'
      else
        'nothing'
      end
    end
  end
end
