module RubyWarrior
  module Abilities
    class Attack < Base
      def perform(direction = :forward)
        @unit.say "attacks #{unit(direction)}"
        receiver = unit(direction)
        if receiver.respond_to? :take_damage
          receiver.take_damage(@unit.attack_power)
          @unit.earn_points(receiver.max_health) unless receiver.alive?
        end
      end
    end
  end
end
