module RubyWarrior
  class Tower
    attr_reader :path
    
    def initialize(path)
      @path = File.join(File.expand_path(File.dirname(__FILE__) + '/../../towers/'), path)
    end
    
    def name
      File.basename(path)
    end
    alias_method :to_s, :name
  end
end
