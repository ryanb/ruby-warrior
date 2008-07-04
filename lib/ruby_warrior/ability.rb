module RubyWarrior
  class Ability
    attr_accessor :owner
    
    def act
      raise "override with subclass"
    end
  end
end
