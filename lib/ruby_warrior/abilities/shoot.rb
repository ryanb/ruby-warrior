module RubyWarrior
  module Abilities
    class Shoot < Base
      def perform(direction = :forward)
        receiver = multi_unit(direction, 1..3).compact.first
        if receiver
          @unit.say "shoots #{receiver}"
          damage(receiver, @unit.shoot_power)
        else
          @unit.say "shoots and misses"
        end
      end
      
      def multi_unit(direction, range)
        range.map { |n| unit(direction, n) }
      end
    end
  end
end
