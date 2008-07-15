module RubyWarrior
  class Level
    attr_reader :profile, :number
    attr_accessor :description, :tip, :warrior
    
    def initialize(profile, number)
      @profile = profile
      @number = number
      @floor = Floor.new
    end
    
    def load_level(level_path)
      loader = LevelLoader.new(self)
      loader.instance_eval(File.read(level_path))
    end
    
    def set_size(width, height)
      @floor.width = width
      @floor.height = height
    end
    
    def width
      @floor.width
    end
    
    def height
      @floor.height
    end
    
    def play(turns = 1000)
      turns.times do |n|
        return if passed? || failed?
        UI.puts "- turn #{n+1} -"
        @floor.units.each { |unit| unit.prepare_turn }
        @floor.units.each { |unit| unit.perform_turn }
        yield if block_given?
      end
    end
    
    def add(*args)
      @floor.add(*args)
    end
    
    def place_stairs(x, y)
      @floor.place_stairs(x, y)
    end
    
    def passed?
      @floor.stairs_space.warrior?
    end
    
    def failed?
      !@floor.units.include?(warrior)
    end
  end
end
