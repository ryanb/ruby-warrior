module RubyWarrior
  class Tower
    attr_reader :name
    
    def initialize(name)
      @name = name
    end
    
    def path
      File.expand_path(File.dirname(__FILE__) + "/../../towers/#{name}")
    end
    
    def level_files
      Dir[path + '/level*']
    end
    
    def file_for_level(number)
      level_files[number - 1]
    end
    
    def build_level(number)
      LevelBuilder.build(file_for_level(number))
    end
  end
end
