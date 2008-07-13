module RubyWarrior
  class Tower
    attr_reader :path
    
    def initialize(path)
      @path = path
    end
    
    def name
      File.basename(path)
    end
    
    def level_paths
      Dir[path + '/level*']
    end
    
    def file_for_level(number)
      level_files[number - 1]
    end
    
    def build_level(number, profile)
      LevelBuilder.build(level_paths[number-1], profile)
    end
  end
end
