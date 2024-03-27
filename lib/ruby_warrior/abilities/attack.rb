module RubyWarrior
  module Abilities
    class Attack < Base
      def description
        "Attacks a unit in given direction (forward by default)."
      end

      def perform(direction = :forward)
        verify_direction(direction)
        receiver = unit(direction)
        if receiver
          @unit.say "attacks #{direction} and hits #{receiver}"
          if direction == :backward
            power = (@unit.attack_power / 2.0).ceil
          else
            power = @unit.attack_power
          end
          damage(receiver, power)
        else
          @unit.say "attacks #{direction} and hits nothing"
        end
      end
    end
  end
end
