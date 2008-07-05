module RubyWarrior
  class Level
    attr_reader :number
    attr_accessor :description, :tip, :goal, :warrior
    
    def initialize(number, width, height)
      @number = number
      @floor = Floor.new(width, height)
    end
    
    def width
      @floor.width
    end
    
    def height
      @floor.height
    end
    
    def play(turns = 1000)
      turns.times do
        return if passed?
        @floor.units.each { |unit| unit.turn }
        yield if block_given?
      end
    end
    
    def add(*args)
      @floor.add(*args)
    end
    
    def passed?
      @floor.get(*goal).kind_of? Warrior if goal
    end
  end
end
