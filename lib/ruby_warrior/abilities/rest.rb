module RubyWarrior
  module Abilities
    class Rest < Base
      def description
        "Gain 10% of max health back, but do nothing more."
      end
      
      def perform
        amount = (@unit.max_health*0.1).round
        @unit.say "receives #{amount} health from resting"
        @unit.health += amount
      end
    end
  end
end
