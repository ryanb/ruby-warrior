module RubyWarrior
  class Engine
    attr_accessor :objects
    
    def initialize
      @objects = []
    end
    
    def play(limit)
      limit.times do
        @objects.each do |obj|
          action = obj.turn
          if action
            action.owner = obj
            action.act
          end
        end
      end
    end
  end
end