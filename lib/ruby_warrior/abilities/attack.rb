module RubyWarrior
  module Abilities
    class Attack < Base
      def description
        "Attack the unit in given direction (forward by default)."
      end
      
      def perform(direction = :forward)
        receiver = unit(direction)
        if receiver
          @unit.say "attacks #{receiver}"
          if direction == :backward
            power = (@unit.attack_power/2.0).ceil
          else
            power = @unit.attack_power
          end
          damage(receiver, power)
        else
          @unit.say "attacks and hits nothing"
        end
      end
    end
  end
end
