module RubyWarrior
  class Level
    attr_reader :number
    attr_accessor :description, :tip, :goal
    
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
        floor.objects.each { |obj| obj.turn }
      end
    end
  end
end
