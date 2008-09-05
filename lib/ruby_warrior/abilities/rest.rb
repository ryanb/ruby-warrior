module RubyWarrior
  module Abilities
    class Rest < Base
      def description
        "Gain 10% of max health back, but do nothing more."
      end
      
      def perform
        amount = (@unit.max_health*0.1).round
        @unit.health += amount
        @unit.say "receives #{amount} health from resting, up to #{@unit.health} health"
      end
    end
  end
end
