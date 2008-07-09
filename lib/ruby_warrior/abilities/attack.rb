module RubyWarrior
  module Abilities
    class Attack < Base
      def perform(direction = :forward)
        @unit.say "attacks #{unit(direction)}"
        if unit(direction).respond_to? :take_damage
          unit(direction).take_damage(@unit.attack_power)
        end
      end
    end
  end
end
