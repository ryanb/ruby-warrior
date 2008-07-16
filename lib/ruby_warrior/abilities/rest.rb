module RubyWarrior
  module Abilities
    class Rest < Base
      def possible_arguments
        [[]]
      end
      
      def perform
        amount = (@unit.max_health*0.1).round
        @unit.say "receives #{amount} health from resting"
        @unit.health += amount
      end
    end
  end
end
