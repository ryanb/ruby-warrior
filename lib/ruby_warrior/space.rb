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

    def golem?
      unit.kind_of? Units::Golem
    end

    def player?
      warrior? || golem?
    end

    def enemy?
      unit && !player? && !captive?
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
      unit && unit.abilities.include?(:explode!)
    end

    def unit
      @floor.get(@x, @y)
    end

    def location
      [@x, @y]
    end

    def character
      if unit
        unit.character
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
        "wall"
      else
        "nothing"
      end
    end
  end
end
