module RubyWarrior
  class Tower
    attr_reader :path
    
    def initialize(path)
      @path = path
    end
    
    def name
      File.basename(path)
    end
  end
end
