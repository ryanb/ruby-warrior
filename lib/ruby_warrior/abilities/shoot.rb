module RubyWarrior
  module Abilities
    class Shoot < Base
      def description
        "Shoot your bow & arrow in given direction (forward by default)."
      end
      
      def perform(direction = :forward)
        receiver = multi_unit(direction, 1..3).compact.first
        if receiver
          @unit.say "shoots #{direction} and hits #{receiver}"
          damage(receiver, @unit.shoot_power)
        else
          @unit.say "shoots and hits nothing"
        end
      end
      
      def multi_unit(direction, range)
        range.map { |n| unit(direction, n) }
      end
    end
  end
end
